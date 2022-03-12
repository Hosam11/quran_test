import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/consts/styles.dart';
import 'package:quran_test/helpers/app_helper.dart';
import 'package:quran_test/helpers/quran_helper.dart';
import 'package:quran_test/provider/quran_provider.dart';
import 'package:quran_test/screens/solution/solution_screen.dart';
import 'package:quran_test/widgets/shared/shared_search_dropdown.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var juzList = List.generate(30, (index) => index + 1);
  var quarterList = List.generate(240, (index) => index + 1);

  late QuranProvider _quranProvider;
  QuranProvider? _updatedQuranProvider;

  int? SelectedStartJuz;
  int? SelectedEndJuz;

  int? selectedStartQuarter;
  int? selectedEndQuarter;

  @override
  void initState() {
    super.initState();
    _quranProvider = Provider.of<QuranProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _updatedQuranProvider = Provider.of<QuranProvider>(context);

    Fimber.i('-');
    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mediumPadding),
            Row(
              children: [
                Expanded(
                  child: SharedSearchDropDown(
                    mLabel: chooseStartJuz,
                    mListItem: juzList,
                    mSelectedValue: SelectedStartJuz,
                    mOnChange: (newVal) => SelectedStartJuz = newVal,
                    mHint: chooseJuz,
                  ),
                ),
                Expanded(
                  child: SharedSearchDropDown(
                    mLabel: chooseEndJuz,
                    mListItem: juzList,
                    mSelectedValue: SelectedEndJuz,
                    mOnChange: (newVal) => SelectedEndJuz = newVal,
                    mHint: chooseJuz,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SharedSearchDropDown(
                    mListItem: quarterList,
                    mOnChange: (newVal) => selectedStartQuarter = newVal,
                    mHint: chooseQuarter,
                    mLabel: fromQuarter,
                    mSelectedValue: selectedStartQuarter,
                  ),
                ),
                Expanded(
                  child: SharedSearchDropDown(
                    mListItem: quarterList,
                    mOnChange: (newVal) => selectedEndQuarter = newVal,
                    mHint: chooseQuarter,
                    mLabel: toQuarter,
                    mSelectedValue: selectedEndQuarter,
                  ),
                ),
              ],
            ),
            SizedBox(height: mediumPadding),

            /// Show random ayah
            ElevatedButton(
              onPressed: showRandomAyahPressed,
              style: btnStyle,
              child: Text(showRandomAyah),
            ),
            SizedBox(height: mediumPadding),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _updatedQuranProvider?.displayedAyah != null
                    ? '\u202E${_updatedQuranProvider?.displayedAyah}'
                    : '',
                style: ayahStyle,
                textAlign: TextAlign.justify,
              ),
            ),
            // no word available
            Visibility(
              visible: _updatedQuranProvider != null
                  ? _updatedQuranProvider!.isWordAvailable
                      ? false
                      : true
                  : false,
              child: Padding(
                padding: const EdgeInsets.all(mediumPadding),
                child: Text(
                  ayahComplete,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red[900],
                  ),
                ),
              ),
            ),
            SizedBox(height: mediumPadding),
            // show solution/another word
            Visibility(
              visible:
                  _updatedQuranProvider?.displayedAyah == null ? false : true,
              child: Padding(
                padding: const EdgeInsets.all(mediumPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: onShowAnotherAyahPressed,
                      style: btnStyle,
                      child: Text(showAnotherAyah),
                    ),
                    // Spacer(),
                    ElevatedButton(
                      onPressed: onShowSolutionPressed,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        textStyle: btnTextStyle,
                        padding: EdgeInsets.symmetric(
                          horizontal: mediumPadding,
                          vertical: smallPadding,
                        ),
                      ),
                      child: Text(
                        showSolution,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ..._updatedQuranProvider!.ayahWithQuarters.entries
            //     .map((e) => Row(
            //           children: [
            //             Text('${e.key}'),
            //             const SizedBox(width: 10.0),
            //             Expanded(child: Text('${e.value}')),
            //             const SizedBox(height: 10),
            //           ],
            //         ))
            //     .toList()
          ],
        ),
      ),
    );
  }

  void onShowSolutionPressed() {
    var firstAyahQuarter = _quranProvider
        .hizbQuModels[_quranProvider.randomAyah!.hizbQuarter! - 1];
    _quranProvider.getSurahName();
    Fimber.i('x= $firstAyahQuarter');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ListenableProvider<QuranProvider>.value(
          value: _quranProvider,
          child: SolutionScreen(
            ayah: _quranProvider.randomAyah!,
            firstAyahQuarter: firstAyahQuarter,
          ),
        ),
      ),
    );
  }

  void onShowAnotherAyahPressed() {
    Fimber.i('-');
    _quranProvider.setDisplayedAyah();
  }

  void getAyahs() {
    // QuranHelper.instance.getQuranFromFile();
    Fimber.i(
        '${_quranProvider.quranModel != null ? 'quran data not null' : 'null'}');
    Fimber.i(
        '${_quranProvider.quranMetaModel != null ? 'quran meta not null' : 'null'}');
    // try {
    var ayahs = QuranHelper.instance.getAyahsByInputs(
      startJuz: SelectedStartJuz,
      endJuz: SelectedEndJuz,
      startQuarter: selectedStartQuarter,
      endQuarter: selectedEndQuarter,
      provider: _quranProvider,
    );
    final surahIndex = ayahs.keys.first;
    Fimber.i('surahIndex= $surahIndex');
    _quranProvider.setupRandomAyah(ayahs.entries.first.value);
    _quranProvider.setSurahName(surahIndex!);
    // } catch (e) {
    //   Fimber.i('e= $e');
    //   showInfoDialogue(context: context, msg: '$e');
    // }
  }

  void showRandomAyahPressed() {
    Fimber.i('\nstartJuzSelected= $SelectedStartJuz'
        '\nendJuzSelected= $SelectedEndJuz'
        '\nselectedStartQuarter= $selectedStartQuarter'
        '\nselectedEndQuarter= $selectedEndQuarter');

    if (SelectedStartJuz == null || SelectedEndJuz == null) {
      Fimber.i('Juzs is null');
      if (selectedStartQuarter == null || selectedEndQuarter == null) {
        Fimber.i('one of quarter is  null');
        showInfoDialogue(context: context, msg: emptyJuzs);
      } else {
        // else: okay
        Fimber.i('two quarter is not null');
        getAyahs();
      }
    } else {
      // else: okay
      Fimber.i('Juzs not  null');
      getAyahs();
    }
  }
}
