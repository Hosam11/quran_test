import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:quran_test/consts/app_colors.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/consts/styles.dart';

class SharedSearchDropDown extends StatelessWidget {
  SharedSearchDropDown({
    Key? key,
    required this.mListItem,
    this.mSelectedValue,
    this.mOnChange,
    this.mLabel,
    this.mHint,
  }) : super(key: key);

  final List<int> mListItem;
  final int? mSelectedValue;
  final String? mLabel;
  final String? mHint;
  final void Function(int?)? mOnChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallPadding),
      child: DropdownSearch<int>(
        items: mListItem,
        // label: mLabel,
        dropdownSearchDecoration: kTextFieldDecoration.copyWith(
          labelText: mLabel,
          hintText: mHint,
          contentPadding: EdgeInsetsDirectional.only(start: 12.0),
          labelStyle: TextStyle(
            color: Colors.black,
            // fontWeight: FontWeight.bold,
          ),
        ),
        dropDownButton: Icon(
          Icons.arrow_drop_down_circle_outlined,
          size: 20,
        ),
        clearButtonBuilder: (c) => Icon(Icons.clear_outlined, size: 20),
        showSearchBox: true,
        onChanged: mOnChange,
        popupBackgroundColor: kSecondaryColor,
        popupTitle: Padding(
          padding: EdgeInsets.all(12.0),
        ),
        selectedItem: mSelectedValue,
        // showAsSuffixIcons: true,
        searchFieldProps: TextFieldProps(
          keyboardType: TextInputType.number,
          decoration: kTextFieldDecoration.copyWith(
            labelText: mHint,
            floatingLabelStyle: TextStyle(color: Colors.black),
          ),
        ),
        emptyBuilder: (_, String? c) => Center(child: Text(entryError)),
        showClearButton: true,
      ),
    );
  }
}
