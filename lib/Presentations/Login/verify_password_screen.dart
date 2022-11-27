import 'dart:async';

import 'package:custom_timer/custom_timer.dart';
import 'package:ecomerce/Data/Mapper/mappers.dart';
import 'package:ecomerce/Data/Network/failure.dart';
import 'package:ecomerce/Domain/Model/model.dart';
import 'package:ecomerce/Presentations/Common/stateRenderer/state_rederer.dart';
import 'package:ecomerce/Presentations/Login/Auth/verify_password_firebase.dart';
import 'package:ecomerce/Presentations/resources/color_manager.dart';
import 'package:ecomerce/Presentations/resources/fonts_manager.dart';
import 'package:ecomerce/Presentations/resources/routes_manager.dart';
import 'package:ecomerce/Presentations/resources/string_manager.dart';
import 'package:ecomerce/Presentations/resources/style_manager.dart';
import 'package:ecomerce/Presentations/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:ecomerce/App/extention.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pinput/pinput.dart';

class verifyPassword extends StatefulWidget {
  final String? phoneNumber;
  verifyPassword({required this.phoneNumber});
  @override
  State<verifyPassword> createState() => _verifyPasswordState();
}

class _verifyPasswordState extends State<verifyPassword> {
  final FocusNode _pinputFocusNode = FocusNode();
  bool _isResendCode = false;

  TextEditingController _pinEditingController = TextEditingController();
  CustomTimerController _customTimerController = CustomTimerController();
  verifyPasswordFirebase _verifyPasswordFirebase =
      verifyPasswordFirebase(Failure(Empty, Empty));
  String? code;
  bool auto = false;
  String? verificationCode;
  bool _autoAuthentication = false;
  @override
  void initState() {
    _verifyPasswordFirebase.verifyPhoneNumber(
        context, widget.phoneNumber.orEmpty());
    _customTimerController.start();
    super.initState();
  }

  void _resendCodeByFirebase() {
    _verifyPasswordFirebase.verifyPhoneNumber(
        context, widget.phoneNumber.orEmpty());
  }

  // Widget runTimerForResendingCode() {
  //   return
  //       //  WidgetsBinding.instance
  //       //       .addPostFrameCallback((_) =>

  //       TweenAnimationBuilder<Duration>(
  //           duration: Duration(seconds: 10),
  //           tween: Tween(
  //               begin: Duration(seconds: _seconds),
  //               end: Duration(seconds: _second2)),
  //           onEnd: () {
  //             setState(() {
  //               _isResendCode = true;
  //             });
  //           },
  //           builder: (BuildContext context, Duration value, Widget? child) {
  //             final minutes = 0;
  //             final seconds = ((10 - value.inSeconds) % 60);
  //             return Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     vertical: appPadding.p5, horizontal: appPadding.p16),
  //                 child: _isResendCode
  //                     ? SizedBox(
  //                         width: MediaQuery.of(context).size.width,
  //                         child: ElevatedButton(
  //                             style: ButtonStyle(
  //                                 padding: MaterialStateProperty.all(
  //                                     const EdgeInsets.symmetric(
  //                                         vertical: appPadding.p16))),
  //                             onPressed: () {
  //                               _resendCodeByFirebase();
  //                               setState(() {
  //                                 _isResendCode = false;

  //                                 _second2 = _second2 - 10;
  //                               });
  //                             },
  //                             child: Text(
  //                               'Resend Code',
  //                               style: getMediumStyle(
  //                                   color: ColorManager.white,
  //                                   fontsize: FontSize.s16),
  //                             )))
  //                     : Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           TextButton(
  //                               onPressed: () {
  //                                 setState(() {});
  //                               },
  //                               child: Text(
  //                                 'Resend Code',
  //                                 style: getMediumStyle(
  //                                     color: Colors.black,
  //                                     fontsize: FontSize.s20),
  //                               )),
  //                           Text('${minutes} : ${seconds}',
  //                               textAlign: TextAlign.center,
  //                               style: getMediumStyle(
  //                                   color: Colors.black,
  //                                   fontsize: FontSize.s20)),
  //                         ],
  //                       ));
  //           });
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: ColorManager.primery,
        ),
        elevation: appSize.s0,
        backgroundColor: ColorManager.white,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorManager.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: appPadding.p15, vertical: appPadding.p8),
              child: Text(
                AppStrings.verifyMobileNumberTitle,
                style: getMediumStyle(
                    color: ColorManager.black, fontsize: FontSize.s18),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(
                  appPadding.p20, appPadding.p5, appPadding.p20, appPadding.p5),
              width: double.infinity,
              child: Text(
                '${AppStrings.VerifyMobileNumberSubtitle} ${widget.phoneNumber.orEmpty()}',
                textAlign: TextAlign.start,
                style: getLightStyle(
                    color: ColorManager.grey, fontsize: FontSize.s15),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: appPadding.p20, vertical: appPadding.p20),
                child: StreamBuilder<Map<String, dynamic>>(
                    stream: _verifyPasswordFirebase.outPutSmsCode,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        code = snapshot.data!['code'];
                        auto = snapshot.data!['auto'];

                        _pinEditingController.setText(code.orEmpty());
                      }
                      return Pinput(
                          length: 6,
                          controller: _pinEditingController,
                          focusNode: _pinputFocusNode,
                          keyboardType: TextInputType.number,
                          closeKeyboardWhenCompleted: true,
                          pinAnimationType: PinAnimationType.fade,
                          onCompleted: (pin) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StateRenderer(
                                      stateRendererType:
                                          StateRendererType.POPUP_LOADING_STATE,
                                      message: AppStrings.Loading,
                                    );
                                  });

                              _verifyPasswordFirebase.pinputOnComplete(
                                  context, pin);
                            });
                          });
                    })),
            _isResendCode
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: appPadding.p16, vertical: appPadding.p12),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: appPadding.p16))),
                            onPressed: () {
                              _resendCodeByFirebase();
                              setState(() {
                                _isResendCode = false;
                                _customTimerController.start();
                              });
                            },
                            child: Text(
                              'Resend Code',
                              style: getMediumStyle(
                                  color: ColorManager.white,
                                  fontsize: FontSize.s16),
                            ))),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: appPadding.p16, vertical: appPadding.p12),
                    child: CustomTimer(
                      controller: _customTimerController,
                      builder: (CustomTimerRemainingTime remaining) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Resend Code',
                              style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontsize: FontSize.s18),
                            ),
                            SizedBox(width: appSize.s28),
                            Text(
                              "${remaining.minutes} : ${remaining.seconds}",
                              style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontsize: FontSize.s18),
                            ),
                          ],
                        );
                      },
                      onChangeState: (customTimerState) {
                        if (customTimerState == CustomTimerState.finished) {
                          setState(() {
                            _isResendCode = true;
                          });
                        }
                      },
                      begin: Duration(minutes: 2, seconds: 1),
                      end: Duration(seconds: 0),
                    ),
                  ),
            // Container(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: appPadding.p20, vertical: appPadding.p20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         child: Text('Resend Code'),
            //       ),
            //       Container(
            //         child: CountdownTimer(
            //           endTime: endTime,
            //           widgetBuilder: (_, time) {
            //             if (time == null) {
            //               setState(() {});
            //             }
            //             return Text(' ${time!.min} : ${time.sec}');
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
