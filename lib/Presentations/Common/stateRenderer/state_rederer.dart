import 'package:ecomerce/Presentations/resources/assets_manager.dart';
import 'package:ecomerce/Presentations/resources/color_manager.dart';
import 'package:ecomerce/Presentations/resources/fonts_manager.dart';
import 'package:ecomerce/Presentations/resources/string_manager.dart';
import 'package:ecomerce/Presentations/resources/style_manager.dart';
import 'package:ecomerce/Presentations/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ecomerce/App/extention.dart';

enum StateRendererType { POPUP_ERROR_STATE, POPUP_LOADING_STATE, POPUP_SUCCESS }

class StateRenderer extends StatefulWidget {
  StateRendererType stateRendererType;
  String message;
  // Function WhatToDoNext;
  StateRenderer({
    required this.stateRendererType,
    required this.message,
    // required this.WhatToDoNext
  });

  @override
  State<StateRenderer> createState() => _StateRendererState();
}

class _StateRendererState extends State<StateRenderer> {
  @override
  Widget build(BuildContext context) {
    return _getContentWidget(context);
  }

  Widget _getContentWidget(BuildContext context) {
    switch (widget.stateRendererType) {
      case StateRendererType.POPUP_ERROR_STATE:
        return PopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(widget.message),
          _WhatToDoNext(context, AppStrings.ok)
        ]);
      case StateRendererType.POPUP_LOADING_STATE:
        return PopUpDialog(context, [
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(widget.message),
        ]);
      default:
        return Container();
    }
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: appSize.s100,
      width: appSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(appPadding.p18),
        child: Text(message,
            textAlign: TextAlign.center,
            style: getMediumStyle(
                color: ColorManager.black, fontsize: FontSize.s15)),
      ),
    );
  }

  Widget _WhatToDoNext(context, String buttonTitle) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(buttonTitle));
  }

  PopUpDialog(context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appSize.s14)),
      elevation: appSize.s1_5,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: appPadding.p8, vertical: appPadding.p20),
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(appSize.s14)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
