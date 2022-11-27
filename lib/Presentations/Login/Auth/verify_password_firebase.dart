import 'dart:async';

import 'package:ecomerce/Data/Mapper/mappers.dart';
import 'package:ecomerce/Data/Network/error_handler.dart';
import 'package:ecomerce/Data/Network/failure.dart';
import 'package:ecomerce/Presentations/Common/stateRenderer/state_rederer.dart';
import 'package:ecomerce/Presentations/Login/user_details_screen.dart';
import 'package:ecomerce/Presentations/Login/verify_password_screen.dart';
import 'package:ecomerce/Presentations/resources/routes_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ecomerce/App/extention.dart';

class verifyPasswordFirebase {
  String? _verificationCode;
  Failure _failure;
  int? _resendToken;
  bool _SubmitUserDone = false;
  bool autoAuthentication = false;
  StreamController<Map<String, dynamic>> _smsCodeStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  Sink get inputSmsCode {
    return _smsCodeStreamController.sink;
  }

  Stream<Map<String, dynamic>> get outPutSmsCode {
    return _smsCodeStreamController.stream.map((code) => code);
  }

  verifyPasswordFirebase(this._failure);

  void verifyPhoneNumber(BuildContext context, String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          autoAuthentication = true;
          inputSmsCode.add({
            'code': phoneAuthCredential.smsCode.orEmpty(),
            'auto': autoAuthentication
          });

          //   await FirebaseAuth.instance
          //       .signInWithCredential(phoneAuthCredential);

          //   if (FirebaseAuth.instance.currentUser!.displayName == null ||
          //       FirebaseAuth.instance.currentUser!.email == null) {
          //     Navigator.of(context).pushNamedAndRemoveUntil(
          //         routes.userDetails, (route) => false);
          //   } else {
          //     Navigator.of(context)
          //         .pushNamedAndRemoveUntil(routes.home, (route) => false);
          //   }
          // } on FirebaseAuthException catch (e) {
          //   _failure = ErrorHandler(e).failure;
          //   Navigator.of(context).pop();
          //   showDialog(
          //       context: context,
          //       builder: (context) {
          //         return StateRenderer(
          //             stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          //             message: _failure.message);
          //       });
          // } catch (e) {
          //   print('error in auth $e');
          //   _failure = ErrorHandler(e).failure;

          //   showDialog(
          //       context: context,
          //       builder: (context) {
          //         return StateRenderer(
          //             stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          //             message: _failure.message);
          //       });
          // }
        },
        verificationFailed: (FirebaseAuthException e) {
          _failure = ErrorHandler(e).failure;
          showDialog(
              context: context,
              builder: (context) {
                return StateRenderer(
                    stateRendererType: StateRendererType.POPUP_ERROR_STATE,
                    message: _failure.message);
              });
        },
        codeSent: (String verificationSMS, int? resendToken) {
          _verificationCode = verificationSMS;
          _resendToken = resendToken;
        },
        forceResendingToken: _resendToken,
        codeAutoRetrievalTimeout: (String verificationSMS) {
          _verificationCode = verificationSMS;
        },
        timeout: const Duration(seconds: 30));
  }

  void pinputOnComplete(BuildContext context, String SmsCode) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: _verificationCode.orEmpty(),
        smsCode: SmsCode,
      ));
      String token = await FirebaseAuth.instance.currentUser!.getIdToken();

      if (FirebaseAuth.instance.currentUser!.displayName == null ||
          FirebaseAuth.instance.currentUser!.email == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(routes.userDetails, (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(routes.nav_screen, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      _failure = ErrorHandler(e).failure;

      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return StateRenderer(
                stateRendererType: StateRendererType.POPUP_ERROR_STATE,
                message: _failure.message);
          });
    } catch (e) {
      print('error in auth $e');
      _failure = ErrorHandler(e).failure;
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return StateRenderer(
                stateRendererType: StateRendererType.POPUP_ERROR_STATE,
                message: _failure.message);
          });
    }
  }

  Future<bool> SubmitUserInfo(
      BuildContext context, String name, String email) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routes.nav_screen, (route) => false);
      _SubmitUserDone = true;
    } on FirebaseAuthException catch (error) {
      print('on firebase auth error $error');
      _failure = ErrorHandler(error).failure;
      showDialog(
          context: context,
          builder: (context) {
            return StateRenderer(
                stateRendererType: StateRendererType.POPUP_ERROR_STATE,
                message: _failure.message);
          });
      _SubmitUserDone = false;
    } catch (error) {
      print('simple error $error');
      _failure = ErrorHandler(error).failure;
      showDialog(
          context: context,
          builder: (context) {
            return StateRenderer(
                stateRendererType: StateRendererType.POPUP_ERROR_STATE,
                message: _failure.message);
          });
      _SubmitUserDone = false;
    }
    return _SubmitUserDone;
  }
}
