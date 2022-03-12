import 'package:flutter/material.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/fonts.dart';
import 'package:quran_test/consts/styles.dart';

class LabelValue extends StatelessWidget {
  final String label;
  final String? value;
  final bool quranFont;

  const LabelValue({
    Key? key,
    required this.label,
    this.value,
    this.quranFont = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallestPadding),
      child: Row(
        children: [
          Text(label, style: kLabelStyle.copyWith(fontWeight: FontWeight.w600)),
          Text(
            value ?? '',
            style: kValueStyle.copyWith(
              fontFamily: quranFont ? meQuranFont : null,
              wordSpacing: 1.5,
            ),
          )
        ],
      ),
    );
  }
}
