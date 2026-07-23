import 'dart:convert';

import 'package:http/http.dart' as http;

class InviteCodeResponse {
  const InviteCodeResponse({
    required this.code,
    required this.albumId,
    required this.ownerName,
  });

  final String code;
  final String albumId;
  final String ownerName;
}

class SharedInviteService {
  SharedInviteService({
    http.Client? client,
    this.baseUrl = 'https://memoryvault-invites.example.workers.dev',
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Future<InviteCodeResponse> createInvite({
    required String albumId,
    required String ownerName,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/invites'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'albumId': albumId, 'ownerName': ownerName}),
    );
    _throwIfBad(response);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return InviteCodeResponse(
      code: body['code'] as String,
      albumId: body['albumId'] as String,
      ownerName: body['ownerName'] as String,
    );
  }

  Future<InviteCodeResponse> resolveInvite(String code) async {
    final response = await _client.get(Uri.parse('$baseUrl/invites/$code'));
    _throwIfBad(response);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return InviteCodeResponse(
      code: body['code'] as String,
      albumId: body['albumId'] as String,
      ownerName: body['ownerName'] as String,
    );
  }

  void _throwIfBad(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError('Invite backend error: ${response.statusCode}');
    }
  }
}
