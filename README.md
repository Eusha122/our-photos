# MemoryVault

MemoryVault is an Android-first Flutter gallery app built around a local-first,
cloud-optional architecture.

## Current implementation

- Premium Flutter app shell with four bottom destinations: Photos, Memories,
  Shared, and Backup.
- Photos contains segmented views for Photos, Timeline, and Albums.
- Drift/SQLite schema is the UI source of truth.
- MediaStore/photo_manager is treated as an indexing input, not the UI database.
- Backblaze B2 backup is modeled as an explicit background queue.
- Sharing uses a tiny invite-code backend contract.
- Hidden Vault is PIN/biometric gated in v1, but not encrypted.

## Local setup

Flutter and Dart are not installed on this machine's PATH yet. After installing
Flutter, run:

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter run
```

For Android release work, create the native Flutter Android host with:

```powershell
flutter create . --platforms=android --org com.memoryvault --project-name memoryvault
```

Keep the existing `lib/`, `test/`, `pubspec.yaml`, and `analysis_options.yaml`
files when Flutter asks about overwrites.
