import 'package:flutter/material.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/styles.dart';

class SharedDropdown extends StatelessWidget {
  const SharedDropdown({
    Key? key,
    required this.mLabel,
    required this.listItem,
    this.selectedValue,
    this.mOnChange,
    this.mOnValidator,
  }) : super(key: key);

  final String mLabel;
  final List<int> listItem;
  final void Function(int?)? mOnChange;
  final String? Function(int?)? mOnValidator;
  final int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallPadding),
      child: DropdownButtonFormField<int>(
        value: selectedValue,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).primaryColor,
        ),
        decoration: kTextFieldDecoration,
        hint: Text(mLabel),
        onChanged: mOnChange,
        items: listItem
            .map<DropdownMenuItem<int>>((int value) => DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value'),
                ))
            .toList(),
        validator: mOnValidator,
      ),
    );
  }
}
