import 'package:flutter/cupertino.dart';

class ColorManager {
  static Color primery = HexColor.FromHex('#FF9100');
  static Color darkGrey = HexColor.FromHex("#525252");
  static Color grey = HexColor.FromHex("#737477");
  static Color lightGrey = HexColor.FromHex("#9E9E9E");
  static Color primeryOpacity70 = HexColor.FromHex("#B3FF9100");
//new colors
  static Color darkPrimery = HexColor.FromHex("#FF6D00");
  static Color grey1 = HexColor.FromHex("#707070");
  static Color grey2 = HexColor.FromHex("#797979");
  static Color white = HexColor.FromHex("#FFFFFF");
  static Color error = HexColor.FromHex("#e61f34");
  static Color black = HexColor.FromHex("#000000");
}

// extension are used for adding the functionality to your class
extension HexColor on ColorManager {
  static Color FromHex(String hexString) {
    hexString = hexString.replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
    // radix is the parameter used for the conversion of string to desired base number . Here it is 16.
    // By default radix is 10.
  }
}
