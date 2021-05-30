import 'package:flutter/material.dart';
import 'package:quran_test/consts/dimens.dart';

const double kFontLabelSize = 20.0;

const TextStyle kLabelStyle = TextStyle(
  fontSize: kFontLabelSize,
);
const TextStyle kValueStyle = TextStyle(
  fontSize: 18,
  color: Colors.green,
);

const EdgeInsets kInputDecorationContentPadding = EdgeInsets.symmetric(
  vertical: 10.0,
  horizontal: 20.0,
);

final TextStyle ayahStyle = TextStyle(
  fontSize: kFontLabelSize,
  color: Colors.green[900],
);

final TextStyle btnTextStyle = TextStyle(
  fontSize: kFontLabelSize,
);

final btnStyle = ElevatedButton.styleFrom(
  textStyle: btnTextStyle,
  padding: EdgeInsets.symmetric(horizontal: mediumPadding, vertical: 8),
);

const InputDecoration kTextFieldDecoration = InputDecoration(
  labelStyle: kLabelStyle,
  contentPadding: kInputDecorationContentPadding,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(1.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);
