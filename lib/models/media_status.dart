enum MediaStatus {
  local('Local', 'device'),
  backedUp('Backed up', 'cloud_done'),
  shared('Shared', 'favorite'),
  uploading('Uploading', 'upload'),
  failed('Failed', 'error'),
  queued('Queued', 'schedule');

  const MediaStatus(this.label, this.iconKey);

  final String label;
  final String iconKey;
}

enum MediaKind {
  photo,
  video,
  gif,
  raw,
}

enum BackupJobState {
  queued,
  thumbnail,
  hashing,
  uploading,
  verifying,
  done,
  failed,
}

enum SmartJobKind {
  duplicate,
  similar,
  blur,
  burst,
  bestShot,
  screenshot,
  receipt,
  document,
  face,
  ocr,
}
