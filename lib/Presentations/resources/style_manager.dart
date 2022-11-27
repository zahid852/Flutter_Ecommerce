import 'package:ecomerce/Presentations/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
  double fontsize,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color);
}

TextStyle getRegulerStyle({double fontsize = 12, required Color color}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.reguler,
    color,
  );
}

TextStyle getLightStyle({double fontsize = 12, required Color color}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.light,
    color,
  );
}

TextStyle getBoldStyle({double fontsize = 12, required Color color}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.Bold,
    color,
  );
}

TextStyle getSemiBoldStyle({double fontsize = 12, required Color color}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.semiBold,
    color,
  );
}

TextStyle getMediumStyle({double fontsize = 12, required Color color}) {
  return _getTextStyle(
    fontsize,
    FontWeightManager.medium,
    color,
  );
}
