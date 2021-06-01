import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/consts/styles.dart';
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';
import 'package:quran_test/provider/quran_provider.dart';

class TryScreen extends StatefulWidget {
  const TryScreen({Key? key}) : super(key: key);

  @override
  _TryScreenState createState() => _TryScreenState();
}

class _TryScreenState extends State<TryScreen> {
  QuranProvider? updateQuranProvider;
  AyahModel? selectedAyahModel;

  @override
  Widget build(BuildContext context) {
    updateQuranProvider = Provider.of<QuranProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('try')),
      floatingActionButton: FloatingActionButton(
        onPressed: edit,
        child: Icon(Icons.edit),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(smallPadding),
            child: DropdownSearch<AyahModel>(
              items: updateQuranProvider?.ayahModels,
              label: 'mLabel',
              dropdownSearchDecoration:
                  kTextFieldDecoration.copyWith(labelText: 'mLabel'),
              hint: ' mHint',
              showSearchBox: true,
              onChanged: (newVal) => selectedAyahModel = newVal,
              selectedItem: selectedAyahModel,
              showAsSuffixIcons: true,
              searchBoxDecoration:
                  kTextFieldDecoration.copyWith(labelText: 'mHint'),
              emptyBuilder: (_, String? c) => Center(child: Text(entryError)),
              showClearButton: true,
            ),
          )
        ],
      ),
    );
  }

  void edit() {
    Fimber.i('ayahModeEncoder= ${jsonEncode(selectedAyahModel)}');
    Fimber.i('ayahModeEncoder= ${updateQuranProvider?.hizbQuModels}');
  }
}
