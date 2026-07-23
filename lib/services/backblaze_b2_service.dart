import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class B2Credentials {
  const B2Credentials({
    required this.keyId,
    required this.applicationKey,
    required this.bucketId,
    required this.bucketName,
    required this.devicePrefix,
  });

  final String keyId;
  final String applicationKey;
  final String bucketId;
  final String bucketName;
  final String devicePrefix;
}

class B2UploadResult {
  const B2UploadResult({
    required this.fileId,
    required this.fileName,
    required this.contentSha1,
  });

  final String fileId;
  final String fileName;
  final String contentSha1;
}

class BackblazeB2Service {
  BackblazeB2Service({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<B2Auth> authorize(B2Credentials credentials) async {
    final token = base64Encode(
      utf8.encode('${credentials.keyId}:${credentials.applicationKey}'),
    );
    final response = await _client.get(
      Uri.parse('https://api.backblazeb2.com/b2api/v3/b2_authorize_account'),
      headers: {'Authorization': 'Basic $token'},
    );
    _throwIfBad(response, 'B2 authorization failed');
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return B2Auth(
      apiUrl: body['apiInfo']['storageApi']['apiUrl'] as String,
      authorizationToken:
          body['apiInfo']['storageApi']['authorizationToken'] as String,
      downloadUrl: body['apiInfo']['storageApi']['downloadUrl'] as String,
    );
  }

  Future<B2UploadResult> uploadSmallFile({
    required B2Credentials credentials,
    required String remotePath,
    required Uint8List bytes,
    required String sha1,
    required String contentType,
  }) async {
    final auth = await authorize(credentials);
    final uploadUrlResponse = await _client.post(
      Uri.parse('${auth.apiUrl}/b2api/v3/b2_get_upload_url'),
      headers: {'Authorization': auth.authorizationToken},
      body: jsonEncode({'bucketId': credentials.bucketId}),
    );
    _throwIfBad(uploadUrlResponse, 'B2 upload URL request failed');
    final uploadInfo =
        jsonDecode(uploadUrlResponse.body) as Map<String, dynamic>;

    final uploadResponse = await _client.post(
      Uri.parse(uploadInfo['uploadUrl'] as String),
      headers: {
        'Authorization': uploadInfo['authorizationToken'] as String,
        'X-Bz-File-Name': Uri.encodeComponent(remotePath),
        'Content-Type': contentType,
        'X-Bz-Content-Sha1': sha1,
      },
      body: bytes,
    );
    _throwIfBad(uploadResponse, 'B2 upload failed');
    final body = jsonDecode(uploadResponse.body) as Map<String, dynamic>;
    return B2UploadResult(
      fileId: body['fileId'] as String,
      fileName: body['fileName'] as String,
      contentSha1: body['contentSha1'] as String,
    );
  }

  Future<bool> verifyFile({
    required B2Credentials credentials,
    required String fileName,
  }) async {
    final auth = await authorize(credentials);
    final response = await _client.post(
      Uri.parse('${auth.apiUrl}/b2api/v3/b2_list_file_names'),
      headers: {'Authorization': auth.authorizationToken},
      body: jsonEncode({
        'bucketId': credentials.bucketId,
        'startFileName': fileName,
        'maxFileCount': 1,
      }),
    );
    _throwIfBad(response, 'B2 verification failed');
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final files = body['files'] as List<dynamic>;
    return files.any((file) => file['fileName'] == fileName);
  }

  void _throwIfBad(http.Response response, String message) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw B2Exception('$message: ${response.statusCode} ${response.body}');
    }
  }
}

class B2Auth {
  const B2Auth({
    required this.apiUrl,
    required this.authorizationToken,
    required this.downloadUrl,
  });

  final String apiUrl;
  final String authorizationToken;
  final String downloadUrl;
}

class B2Exception implements Exception {
  B2Exception(this.message);

  final String message;

  @override
  String toString() => message;
}
