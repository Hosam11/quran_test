import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_test/consts/app_colors.dart';
import 'package:quran_test/consts/locals.dart';
import 'package:quran_test/consts/strings.dart';
import 'package:quran_test/provider/quran_provider.dart';
import 'package:quran_test/screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runAppSpector();
  Fimber.plantTree(DebugTree.elapsed());

  runApp(QuranTestApp());
}

class QuranTestApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: kPrimaryColor,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: kPrimaryColor,
          selectionColor: kPrimaryColor,
          selectionHandleColor: kPrimaryColor,
        ),
        backgroundColor: kPrimaryColor,
        scaffoldBackgroundColor: kSecondaryColor,
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => QuranProvider(),
        child: HomeScreen(),
      ),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocals,
      locale: curLocal,
    );
  }
}
