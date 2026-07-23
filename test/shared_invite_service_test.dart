import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:memoryvault/services/shared_invite_service.dart';

void main() {
  test('createInvite parses invite-code backend response', () async {
    final service = SharedInviteService(
      baseUrl: 'https://example.test',
      client: MockClient((request) async {
        expect(request.url.path, '/invites');
        return http.Response(
          '{"code":"ABCD-1234","albumId":"album-1","ownerName":"Owner"}',
          200,
        );
      }),
    );

    final invite = await service.createInvite(
      albumId: 'album-1',
      ownerName: 'Owner',
    );

    expect(invite.code, 'ABCD-1234');
    expect(invite.albumId, 'album-1');
  });
}
