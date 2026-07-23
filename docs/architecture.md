# MemoryVault Architecture

## Local-first data flow

```text
Android MediaStore/photo_manager
  -> MediaIndexerService
  -> Drift SQLite
  -> Repositories
  -> Gallery UI
```

MediaStore is never queried directly by feature UI. It is an input stream for
the local database.

## Backup flow

```text
Photo added
  -> Queue
  -> Thumbnail cache
  -> Hash
  -> B2 upload
  -> Verify
  -> Done
```

The UI never starts an upload directly. It only adds work to the queue.

## Sharing flow

Owner creates an invite code through a tiny backend. The partner enters the code
and receives the shared album manifest location and role metadata. B2 remains
the object store.

No email, passwords, Firebase Auth, or encryption are included in v1.
