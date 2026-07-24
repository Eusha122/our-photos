package com.memoryvault.memoryvault

import io.flutter.embedding.android.FlutterFragmentActivity

// local_auth's Android biometric prompt (BiometricPrompt) needs a host
// Activity that is a FragmentActivity to attach its dialog to — plain
// FlutterActivity doesn't extend FragmentActivity, so authenticate() would
// fail. FlutterFragmentActivity is a drop-in replacement that adds that.
class MainActivity : FlutterFragmentActivity()
