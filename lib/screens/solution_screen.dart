import 'package:flutter/material.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/consts/styles.dart';
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';

class SolutionScreen extends StatelessWidget {
  final AyahModel ayah;
  const SolutionScreen({Key? key, required this.ayah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(solutionScreenTitle)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(smallestPadding),
                child: Row(
                  children: [
                    Text(juz, style: kLabelStyle),
                    Text(
                      ayah.juz != null ? ayah.juz.toString() : '',
                      style: kValueStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(smallestPadding),
                child: Row(
                  children: [
                    Text(quarter, style: kLabelStyle),
                    Text(
                      ayah.hizbQuarter != null
                          ? ayah.hizbQuarter.toString()
                          : '',
                      style: kValueStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(smallestPadding),
                child: Text(ayah.text ?? '', style: ayahStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
