import 'dart:convert';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/helpers/app_helper.dart';
import 'package:quran_test/helpers/quran_helper.dart';
import 'package:quran_test/provider/quran_provider.dart';
import 'package:quran_test/widgets/shared/shared_search_dropdown.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var juzList = List.generate(30, (index) => index + 1);
  var quarterList = List.generate(240, (index) => index + 1);

  QuranProvider? _quranProvider;
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
      floatingActionButton: FloatingActionButton(
        onPressed: onShowAnotherAyahPressed,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SharedSearchDropDown(
                    mLabel: chooseStartJuz,
                    mListItem: juzList,
                    mSelectedValue: SelectedStartJuz,
                    mOnChange: (newVal) => SelectedStartJuz = newVal,
                    mHint: chooseStartJuz,
                  ),
                ),
                Expanded(
                  child: SharedSearchDropDown(
                    mLabel: chooseEndJuz,
                    mListItem: juzList,
                    mSelectedValue: SelectedEndJuz,
                    mOnChange: (newVal) => SelectedEndJuz = newVal,
                    mHint: chooseEndJuz,
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
            ElevatedButton(
              onPressed: showRandomAyahPressed,
              child: Text(showRandomAyah),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _updatedQuranProvider?.displayedAyah ?? '',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green[900],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onShowAnotherAyahPressed,
                    child: Text(showAnotherAyah),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onShowSolutionPressed,
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text(showSolution),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onShowSolutionPressed() {}

  void onShowAnotherAyahPressed() {
    var isNewWord = _quranProvider?.setDisplayedAyah();
    Fimber.i('isNewWord= $isNewWord');
  }

  void getAyahs() {
    Fimber.i('buttonPressed');
    // QuranHelper.instance.getQuranFromFile();
    Fimber.i(
        '${_quranProvider?.quranModel != null ? 'quran data not null' : 'null'}');
    Fimber.i(
        '${_quranProvider?.quranMetaModel != null ? 'quran meta not null' : 'null'}');
    var ayahs = QuranHelper.instance.getAyahsByInputs(
      startJuz: SelectedStartJuz,
      endJuz: SelectedEndJuz,
      startQuarter: selectedStartQuarter,
      endQuarter: selectedEndQuarter,
      provider: _quranProvider!,
    );
    _quranProvider?.setupRandomAyah(ayahs);
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
