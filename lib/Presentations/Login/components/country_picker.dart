import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomerce/Presentations/resources/fonts_manager.dart';
import 'package:ecomerce/Presentations/resources/string_manager.dart';
import 'package:ecomerce/Presentations/resources/style_manager.dart';
import 'package:ecomerce/Presentations/resources/values_manager.dart';
import 'package:flutter/material.dart';

class countryCodePicker extends StatelessWidget {
  String countryCode = '+92';
  String getCountryCode() {
    return countryCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CountryCodePicker(
        padding: const EdgeInsets.only(top: 10),
        onChanged: (Code) {
          countryCode = Code as String;
        },
        dialogSize: MediaQuery.of(context).size,
        initialSelection: '+92',
        textStyle: getMediumStyle(color: Colors.black, fontsize: FontSize.s16),
        showFlagDialog: true,
        showDropDownButton: true,
        favorite: const ['+92'],
      ),
    );
  }
}
