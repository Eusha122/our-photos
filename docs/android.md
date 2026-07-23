# Android Notes

The first verified platform is Android.

Required native setup after running `flutter create`:

- Add media permissions for Android 13+:
  - `READ_MEDIA_IMAGES`
  - `READ_MEDIA_VIDEO`
  - selected-photo access behavior for Android 14+
- Configure `workmanager` background tasks.
- Configure `local_auth` biometric prompts.
- Add a foreground notification channel for long backup/export jobs.
- Keep delete behavior recycle-first. Permanent deletion must go through an
  explicit confirmation and Android media deletion request.
