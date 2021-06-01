import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                child: Row(
                  children: [
                    Text(ayahNumber, style: kLabelStyle),
                    Text(
                      ayah.numberInSurah != null ? '${ayah.numberInSurah}' : '',
                      style: kValueStyle,
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(smallestPadding),
                  child: Text(
                    ayah.text != null ? '\u202E${ayah.text} ' : '',
                    textAlign: TextAlign.justify,
                    style: ayahStyle,
                  ) /*RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: '\u202E${ayah.text}',
                    style: ayahStyle,
                    children: [
                      TextSpan(
                        // text: ' \uFD3F${ayah.numberInSurah}\uFD3E',
                        text: ' ${ayah.numberInSurah}',
                        style: GoogleFonts.amiri(),
                      )
                    ],
                  ),

                  */ /*child: Text(
                      ayah.text != null
                          ? '${ayah.text} \uFD3F${ayah.number}\uFD3E'
                          : '',
                      style: ayahStyle),*/ /*
                ),*/
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
