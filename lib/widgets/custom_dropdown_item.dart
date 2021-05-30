import 'package:flutter/material.dart';
import 'package:quran_test/consts/strings.dart' as strings;
import 'package:quran_test/data/model/quran/ayah_model/ayah_model.dart';

class CustomDropDownItem extends StatelessWidget {
  CustomDropDownItem({this.ayahModel});

  final AyahModel? ayahModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (ayahModel == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(),
              title: Text(strings.entryError),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text('${ayahModel?.number}, '),
            ),
    );
  }
}
