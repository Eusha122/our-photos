# Android Notes

The first verified platform is the user's physical Pixel 7 Pro.

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

Pixel 7 Pro run checklist:

- Enable Developer options on the phone.
- Enable USB debugging.
- Connect over USB with a data-capable cable.
- Accept the RSA debugging prompt on the phone.
- Run `F:\flutter\bin\flutter.bat devices`.
- Run `F:\flutter\bin\flutter.bat run -d <pixel-device-id>`.
