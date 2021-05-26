import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/consts/styles.dart';
import 'package:quran_test/helpers/app_helper.dart';
import 'package:quran_test/helpers/quran_helper.dart';
import 'package:quran_test/widgets/shared/shared_dropdown.dart';
import 'package:quran_test/widgets/shared/shared_search_dropdown.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

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

  void find() {
    // juzList.where((evyslement) => e.)
  }

  @override
  Widget build(BuildContext context) {
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
    logger.i('buttonPressed');
    QuranHelper.instance.getAllQuran();
  }
}
