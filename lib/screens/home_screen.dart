import 'package:flutter/material.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/helpers/app_helper.dart';
import 'package:quran_test/helpers/quran_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPressed,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Text(''),
        ],
      ),
    );
  }

  void onAddPressed() {
    logger.i('buttonPressed');
    QuranHelper.instance.getAllQuran();
  }
}
