import 'package:flutter/material.dart';
import 'package:quran_test/consts/app_colors.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/fonts.dart';

const kFontLabelSize = 20.0;

const kLabelStyle = TextStyle(fontSize: kFontLabelSize);
final kValueStyle = TextStyle(fontSize: 18);

const kInputDecorationContentPadding =
    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);

final ayahStyle = TextStyle(
  fontSize: 25,
  color: Colors.green[900],
  fontFamily: meQuranFont,
);

final btnTextStyle = TextStyle(fontSize: kFontLabelSize);

final btnStyle = ElevatedButton.styleFrom(
  textStyle: btnTextStyle,
  padding: EdgeInsets.symmetric(horizontal: mediumPadding, vertical: 8),
  primary: kPrimaryColor,
);

const kTextFieldDecoration = InputDecoration(
  labelStyle: kLabelStyle,
  // floatingLabelStyle: TextStyle(color: kPrimaryColor),
  contentPadding: kInputDecorationContentPadding,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(1.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);
