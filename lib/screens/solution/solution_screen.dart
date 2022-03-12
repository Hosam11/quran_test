import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/consts/styles.dart';
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';
import 'package:quran_test/provider/quran_provider.dart';
import 'package:quran_test/widgets/label_value.dart';

class SolutionScreen extends StatelessWidget {
  final AyahModel ayah;

  final AyahModel firstAyahQuarter;

  const SolutionScreen({
    Key? key,
    required this.ayah,
    required this.firstAyahQuarter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ayahPreview = QuranHelper.instance.getAyahPreview(firstAyahQuarter);
    final ayahPreview =
        Provider.of<QuranProvider>(context).getQuarterText(ayah.hizbQuarter!);
    return Scaffold(
      appBar: AppBar(title: Text(solutionScreenTitle)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // juzLabel
              LabelValue(
                label: juzLabel,
                value: ayah.juz != null ? ayah.juz.toString() : null,
              ),
              // quarterLabel
              LabelValue(
                label: quarterLabel,
                quranFont: true,
                value: ayah.hizbQuarter != null
                    ? '${ayah.hizbQuarter} - $ayahPreview'
                    : null,
              ),
              // ayahNumberLabel
              LabelValue(
                label: surahNameLabel,
                value: Provider.of<QuranProvider>(context).surahName,
              ),
              LabelValue(
                label: ayahNumberLabel,
                value:
                    ayah.numberInSurah != null ? '${ayah.numberInSurah}' : null,
              ),
              Padding(
                padding: const EdgeInsets.all(smallestPadding),
                child: Text(
                  ayah.text != null ? '\u202E${ayah.text} ' : '',
                  textAlign: TextAlign.justify,
                  style: ayahStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
