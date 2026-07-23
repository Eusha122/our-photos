const json = (body, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: {
      'content-type': 'application/json; charset=utf-8',
      'access-control-allow-origin': '*',
      'access-control-allow-methods': 'GET,POST,OPTIONS',
      'access-control-allow-headers': 'content-type',
    },
  });

const code = () =>
  Math.random().toString(36).slice(2, 6).toUpperCase() +
  '-' +
  Math.random().toString(36).slice(2, 6).toUpperCase();

export default {
  async fetch(request, env) {
    if (request.method === 'OPTIONS') return json({});

    const url = new URL(request.url);
    if (request.method === 'POST' && url.pathname === '/invites') {
      const body = await request.json();
      const inviteCode = code();
      await env.DB.prepare(
        `insert into invites (code, album_id, owner_name, created_at)
         values (?, ?, ?, datetime('now'))`,
      )
        .bind(inviteCode, body.albumId, body.ownerName)
        .run();
      return json({
        code: inviteCode,
        albumId: body.albumId,
        ownerName: body.ownerName,
      });
    }

    const match = url.pathname.match(/^\/invites\/([^/]+)$/);
    if (request.method === 'GET' && match) {
      const invite = await env.DB.prepare(
        `select code, album_id as albumId, owner_name as ownerName
         from invites where code = ?`,
      )
        .bind(match[1].toUpperCase())
        .first();
      if (!invite) return json({error: 'Invite not found'}, 404);
      return json(invite);
    }

    return json({error: 'Not found'}, 404);
  },
};
