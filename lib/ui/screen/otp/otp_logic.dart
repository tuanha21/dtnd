import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../utilities/logger.dart';
import 'otp_state.dart';

class OtpLogic extends GetxController {
  final String phone;
  final OtpState state = OtpState();

  OtpLogic(this.phone);

  Future<void> validateOTp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!,
        smsCode: state.pinPutController.text);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      var user = FirebaseAuth.instance.currentUser;
      var token = await user?.getIdToken();
      if (kDebugMode) {
        print('token ===> $token');
      }
    } catch (_) {
      rethrow;
    }
  }

  /// lấy otp gửi về điện thoại
  Future<void> otpAuthentication() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+84$phone",
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (Platform.isIOS) {
          await FirebaseAuth.instance.signInWithCredential(credential);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        logger.e(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        logger.d(verificationId);
        state.verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        state.verificationId = verificationId;
      },
    );
  }

  @override
  void onReady() {
    otpAuthentication();
    super.onReady();
  }
}
