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
        label: mLabel,
        dropdownSearchDecoration:
            kTextFieldDecoration.copyWith(labelText: mLabel),
        hint: mHint,
        showSearchBox: true,
        onChanged: mOnChange,
        selectedItem: mSelectedValue,
        showAsSuffixIcons: true,
        searchBoxDecoration: kTextFieldDecoration.copyWith(labelText: mHint),
        emptyBuilder: (_, String? c) => Center(child: Text(entryError)),
        showClearButton: true,
      ),
    );
  }
}
