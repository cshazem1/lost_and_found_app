import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

String getFirebaseAuthErrorMessage(String code, BuildContext context) {
  switch (code) {
    case 'email-already-in-use':
      return S.of(context).emailAlreadyInUse;
    case 'invalid-email':
      return S.of(context).invalidEmail;
    case 'weak-password':
      return S.of(context).weakPassword;
    case 'user-not-found':
      return S.of(context).userNotFound;
    case 'wrong-password':
      return S.of(context).wrongPassword;
    default:
      return S.of(context).unexpectedError;
  }
}
