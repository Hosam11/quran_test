import 'package:flutter/material.dart';
import 'package:quran_test/consts/locals.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/helpers/app_helper.dart';
import 'package:quran_test/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runAppSpector();

  runApp(QuranTestApp());
}

class QuranTestApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocals,
      locale: curLocal,
    );
  }
}
