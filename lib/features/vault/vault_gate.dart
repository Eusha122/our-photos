import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class VaultGate {
  VaultGate({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  Future<bool> unlock(BuildContext context) async {
    final canAuthenticate = await _auth.canCheckBiometrics ||
        await _auth.isDeviceSupported();
    if (!canAuthenticate) return false;
    return _auth.authenticate(
      localizedReason: 'Unlock Hidden Vault',
      options: const AuthenticationOptions(biometricOnly: false),
    );
  }
}
