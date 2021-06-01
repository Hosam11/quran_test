import 'package:flutter/material.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/styles.dart';

class LabelValue extends StatelessWidget {
  final String label;
  final String? value;

  const LabelValue({Key? key, required this.label, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallestPadding),
      child: Row(
        children: [
          Text(label, style: kLabelStyle),
          Text(value ?? '', style: kValueStyle)
        ],
      ),
    );
  }
}
