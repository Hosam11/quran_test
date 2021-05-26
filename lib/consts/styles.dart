import 'package:flutter/material.dart';

const double kFontLabelSize = 20.0;

const TextStyle kFontLabelStyle = TextStyle(
  fontSize: kFontLabelSize,
);

const EdgeInsets kInputDecorationContentPadding = EdgeInsets.symmetric(
  vertical: 10.0,
  horizontal: 20.0,
);

const InputDecoration kTextFieldDecoration = InputDecoration(
  labelStyle: kFontLabelStyle,
  contentPadding: kInputDecorationContentPadding,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(1.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);
