import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
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

  final List<String> mListItem;
  final String? mSelectedValue;
  final String? mLabel;
  final String? mHint;
  final void Function(String?)? mOnChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallPadding),
      child: DropdownSearch<String>(
        items: mListItem,
        label: mLabel,
        dropdownSearchDecoration: kTextFieldDecoration,
        hint: mHint,
        showSearchBox: true,
        onChanged: mOnChange,
        selectedItem: mSelectedValue,
        showAsSuffixIcons: true,
        searchBoxDecoration: kTextFieldDecoration,
        emptyBuilder: (_, String? c) => Center(child: Text(entryError)),
      ),
    );
  }
}
