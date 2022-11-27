import 'package:ecomerce/Data/Mapper/mappers.dart';
import 'package:ecomerce/Data/Network/failure.dart';
import 'package:ecomerce/Presentations/Login/Auth/verify_password_firebase.dart';
import 'package:ecomerce/Presentations/Login/components/login_view_model.dart';
import 'package:ecomerce/Presentations/Login/verify_password_screen.dart';
import 'package:ecomerce/Presentations/resources/color_manager.dart';
import 'package:ecomerce/Presentations/resources/fonts_manager.dart';
import 'package:ecomerce/Presentations/resources/routes_manager.dart';
import 'package:ecomerce/Presentations/resources/string_manager.dart';
import 'package:ecomerce/Presentations/resources/style_manager.dart';
import 'package:ecomerce/Presentations/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:ecomerce/Presentations/resources/routes_manager.dart';
import 'package:flutter/services.dart';

class userDetailsScreen extends StatefulWidget {
  @override
  State<userDetailsScreen> createState() => _userDetailsScreenState();
}

class _userDetailsScreenState extends State<userDetailsScreen> {
  bool _isSumbitUserDone = false;
  verifyPasswordFirebase _verifyPasswordFirebase =
      verifyPasswordFirebase(Failure(Empty, Empty));
  loginViewModel _viewModel = loginViewModel();
  TextEditingController _NameEditingController = TextEditingController();
  TextEditingController _EmailEditingController = TextEditingController();

  bool _isLoading = false;
  void _bind() {
    _NameEditingController.addListener(
        () => _viewModel.setName(_NameEditingController.text.trim()));

    _EmailEditingController.addListener(
        () => _viewModel.setEmail(_EmailEditingController.text.trim()));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _userInfoFieldTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: appPadding.p15, vertical: appPadding.p8),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: getMediumStyle(
          color: ColorManager.black,
          fontsize: FontSize.s17,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          print('tap');
          FocusScope.of(context).requestFocus(FocusNode());
          // FocusManager.instance.primaryFocus
          //     ?.unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: appSize.s0,
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorManager.white,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: appPadding.p5, bottom: appPadding.p30),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Personal Information',
                              textAlign: TextAlign.center,
                              style: getMediumStyle(
                                color: ColorManager.primery,
                                fontsize: FontSize.s20,
                              ),
                            ),
                          ),
                        ),
                        _userInfoFieldTitle("What's your name?"),
                        Container(
                          padding: const EdgeInsets.only(
                              left: appPadding.p20,
                              bottom: appPadding.p30,
                              right: appPadding.p20,
                              top: appPadding.p2),
                          child: StreamBuilder<bool>(
                              stream: _viewModel.OutputIsNameValid,
                              builder: (context, snapshot) {
                                return StreamBuilder<bool>(
                                    stream: _viewModel.OutputIsNameFieldFocus,
                                    builder: (context, focusSnapshot) {
                                      return Focus(
                                        onFocusChange: (focusStatus) {
                                          print('name focus $focusStatus');
                                          _viewModel
                                              .setNameFieldFocus(focusStatus);
                                        },
                                        child: TextField(
                                          controller: _NameEditingController,
                                          cursorColor: ColorManager.black,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: getRegulerStyle(
                                              color: Colors.black,
                                              fontsize: FontSize.s17),
                                          decoration: InputDecoration(
                                            hintText: 'Enter your name',
                                            contentPadding:
                                                const EdgeInsets.only(top: 10),
                                            hintStyle: getLightStyle(
                                                color: ColorManager.grey,
                                                fontsize: FontSize.s17),
                                            suffixIcon: _NameEditingController
                                                    .text.isEmpty
                                                ? null
                                                : (focusSnapshot.data == false
                                                    ? null
                                                    : IconButton(
                                                        onPressed: () {
                                                          _NameEditingController
                                                              .clear();
                                                        },
                                                        icon: const Icon(
                                                            Icons.close),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: appPadding
                                                                    .p12),
                                                      )),
                                            prefixIcon: const Padding(
                                              padding: EdgeInsets.only(top: 8),
                                              child: Icon(Icons.person),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ),
                        _userInfoFieldTitle("What's your email?"),
                        Container(
                          padding: const EdgeInsets.only(
                              left: appPadding.p20,
                              bottom: appPadding.p30,
                              right: appPadding.p20,
                              top: appPadding.p2),
                          child: StreamBuilder<bool>(
                              stream: _viewModel.OutputIsEmailValid,
                              builder: (context, snapshot) {
                                return StreamBuilder<bool>(
                                    stream: _viewModel.OutputIsEmailFocus,
                                    builder: (context, focusSnapshot) {
                                      return Focus(
                                        onFocusChange: (focusStatus) {
                                          print('email focus $focusStatus');
                                          _viewModel
                                              .setEmailFieldFocus(focusStatus);
                                        },
                                        child: TextField(
                                          controller: _EmailEditingController,
                                          cursorColor: ColorManager.black,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: getRegulerStyle(
                                              color: Colors.black,
                                              fontsize: FontSize.s17),
                                          decoration: InputDecoration(
                                            hintText: 'Enter your email',
                                            contentPadding:
                                                const EdgeInsets.only(top: 10),
                                            hintStyle: getLightStyle(
                                                color: ColorManager.grey,
                                                fontsize: FontSize.s17),
                                            suffixIcon: _EmailEditingController
                                                    .text.isEmpty
                                                ? null
                                                : (focusSnapshot.data == false
                                                    ? null
                                                    : IconButton(
                                                        onPressed: () {
                                                          _EmailEditingController
                                                              .clear();
                                                        },
                                                        icon: const Icon(
                                                            Icons.close),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: appPadding
                                                                    .p12),
                                                      )),
                                            prefixIcon: const Padding(
                                              padding: EdgeInsets.only(top: 8),
                                              child: Icon(Icons.email),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      bottom: appPadding.p14,
                      left: appPadding.p15,
                      right: appPadding.p15),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.OutputIsAllInputValid,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: appPadding.p16))),
                            onPressed: (snapshot.data ?? false)
                                ? () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    _isSumbitUserDone =
                                        await _verifyPasswordFirebase
                                            .SubmitUserInfo(
                                                context,
                                                _NameEditingController.text,
                                                _EmailEditingController.text);
                                    if (!_isSumbitUserDone)
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                  }
                                : null,
                            child: _isLoading
                                ? Center(
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.transparent,
                                      child: CircularProgressIndicator(
                                        color: ColorManager.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Submit',
                                    style: getMediumStyle(
                                        color: ColorManager.white,
                                        fontsize: FontSize.s16),
                                  ));
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
