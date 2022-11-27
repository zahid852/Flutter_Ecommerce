import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomerce/Domain/Model/model.dart';
import 'package:ecomerce/Presentations/Login/components/country_picker.dart';
import 'package:ecomerce/Presentations/Login/components/login_view_model.dart';
import 'package:ecomerce/Presentations/resources/color_manager.dart';
import 'package:ecomerce/Presentations/resources/fonts_manager.dart';
import 'package:ecomerce/Presentations/resources/routes_manager.dart';
import 'package:ecomerce/Presentations/resources/string_manager.dart';
import 'package:ecomerce/Presentations/resources/style_manager.dart';
import 'package:ecomerce/Presentations/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:ecomerce/App/extention.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  loginViewModel _viewModel = loginViewModel();
  countryCodePicker country_code_Picker = countryCodePicker();
  TextEditingController _PhoneNumberEditingController = TextEditingController();
  String? phoneNumber;
  _bind() {
    _PhoneNumberEditingController.addListener(
        () => _viewModel.setPhoneNumber(_PhoneNumberEditingController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: appSize.s0,
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //       color: ColorManager.primery,
          //     )),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: appPadding.p15,
                            vertical: appPadding.p8),
                        width: double.infinity,
                        child: Text(
                          AppStrings.EnterMobileNumberTitle,
                          textAlign: TextAlign.start,
                          style: getMediumStyle(
                              color: ColorManager.black,
                              fontsize: FontSize.s18),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(appPadding.p15,
                            appPadding.p5, appPadding.p15, appPadding.p5),
                        width: double.infinity,
                        child: Text(
                          AppStrings.EnterMobileNumberSubtitle,
                          textAlign: TextAlign.start,
                          style: getLightStyle(
                              color: ColorManager.grey, fontsize: FontSize.s15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: appPadding.p20,
                            bottom: appPadding.p12,
                            right: appPadding.p20,
                            top: appPadding.p12),
                        child: StreamBuilder<bool>(
                            stream: _viewModel.OutputIsNumberValid,
                            builder: (context, snapshot) {
                              return TextField(
                                controller: _PhoneNumberEditingController,
                                cursorColor: ColorManager.black,
                                keyboardType: TextInputType.number,
                                textAlignVertical: TextAlignVertical.center,
                                maxLength: 10,
                                style: getMediumStyle(
                                    color: Colors.black,
                                    fontsize: FontSize.s17),
                                decoration: InputDecoration(
                                  hintText: AppStrings.hintPhoneNumber,
                                  suffixIcon:
                                      _PhoneNumberEditingController.text.isEmpty
                                          ? null
                                          : IconButton(
                                              onPressed: () {
                                                print(
                                                    'phone ${_PhoneNumberEditingController.text}');
                                                _PhoneNumberEditingController
                                                    .clear();
                                              },
                                              icon: Icon(Icons.close),
                                              padding: EdgeInsets.only(
                                                  top: appPadding.p12),
                                            ),
                                  contentPadding:
                                      const EdgeInsets.only(top: 10),
                                  hintStyle: getLightStyle(
                                      color: ColorManager.grey,
                                      fontsize: FontSize.s17),
                                  prefixIcon: countryCodePicker(),
                                ),
                              );
                            }),
                      )
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
                    stream: _viewModel.OutputIsNumberValid,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: appPadding.p16))),
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  phoneNumber =
                                      '${country_code_Picker.countryCode}${_PhoneNumberEditingController.text}';
                                  Navigator.of(context).pushNamed(
                                      routes.verifyPassword,
                                      arguments: phoneNumber);
                                }
                              : null,
                          child: Text(
                            AppStrings.sendCode,
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
  }
}
