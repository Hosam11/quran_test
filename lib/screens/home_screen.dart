import 'dart:convert';
import 'dart:developer';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/helpers/quran_helper.dart';
import 'package:quran_test/provider/quran_provider.dart';
import 'package:quran_test/widgets/shared/shared_dropdown.dart';
import 'package:quran_test/widgets/shared/shared_search_dropdown.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var listx = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
  ];

  var juzList = List.generate(30, (index) => index + 1);

  int? startJuzSelected;

  String? select;

  int? endJuzSelected;

  QuranProvider? _quranProvider;

  @override
  void initState() {
    super.initState();
    _quranProvider = Provider.of<QuranProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Fimber.i('-');
    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPressed,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SharedDropdown(
                    mLabel: chooseStartJuz,
                    listItem: juzList,
                    selectedValue: startJuzSelected,
                    mOnChange: (newValue) => newValue = startJuzSelected,
                  ),
                ),
                Expanded(
                  child: SharedDropdown(
                    mLabel: chooseEndJuz,
                    listItem: juzList,
                    selectedValue: endJuzSelected,
                    mOnChange: (newValue) => endJuzSelected = newValue,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SharedSearchDropDown(
                    mListItem: listx,
                    mOnChange: (newVal) => print(newVal),
                    mHint: 'اختر ربع',
                    mLabel: 'من الربع',
                    mSelectedValue: select,
                  ),
                ),
                Expanded(
                  child: SharedSearchDropDown(
                    mListItem: listx,
                    mOnChange: (newVal) => print(newVal),
                    mHint: 'اختر ربع',
                    mLabel: 'الي الربع',
                    mSelectedValue: select,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onAddPressed() {
    /*
      if juz null:
        check if qurter null:
          error juz must be provided
        else: okay
      else:
        okay
    */
    Fimber.i('buttonPressed');
    // QuranHelper.instance.getQuranFromFile();
    Fimber.i(
        '${_quranProvider?.quranModel != null ? 'quran data not null' : 'null'}');
    Fimber.i(
        '${_quranProvider?.quranMetaModel != null ? 'quran meta not null' : 'null'}');

    var ayahs = QuranHelper.instance.getAyahs(
      startQuarter: 1,
      endQuarter: 5,
      startJuz: 1,
      endJuz: 1,
      provider: _quranProvider!,
    );

    Fimber.i('ayahsLen= ${ayahs.length}');
    // log('ayahs= \n${jsonEncode(ayahs)}');
    Fimber.i('ayahslast= ${jsonEncode(ayahs.last)}');
  }
}
