create table if not exists invites (
  code text primary key,
  album_id text not null,
  owner_name text not null,
  partner_name text,
  created_at text not null,
  accepted_at text,
  revoked_at text
);
