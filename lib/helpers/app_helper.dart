import 'package:flutter/material.dart';
import 'package:quran_test/consts/app_colors.dart';
import 'package:quran_test/consts/dimens.dart';
import 'package:quran_test/consts/styles.dart';

/*void runAppSpector() {
  var apiKey = 'android_ZGE3YmY3MzMtODQ0NS00YmIyLThiMzQtNTAzZmZkMDkwNDJi';
  final config = Config()..androidApiKey = apiKey;

  // If you don't want to start all monitors you can specify a list of necessary ones
  config.monitors = <Monitor>[
    Monitors.http,
    Monitors.logs,
    Monitors.fileSystem,
    Monitors.screenshot,
    Monitors.environment,
    Monitors.location,
    Monitors.performance,
    Monitors.sqLite,
    Monitors.sharedPreferences,
    Monitors.analytics,
    Monitors.notification,
    Monitors.userDefaults,
    Monitors.coreData
  ];

  AppSpectorPlugin.run(config);
}*/

Future<void> showInfoDialogue({
  required BuildContext context,
  required String msg,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: kPrimaryColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(msg, style: TextStyle(color: Colors.white)),
          const SizedBox(height: 12.0),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              primary: kSecondaryColor,
              textStyle: btnTextStyle,
              padding: EdgeInsets.symmetric(
                horizontal: mediumPadding,
                vertical: smallPadding,
              ),
            ),
            // style: btnStyle.copyWith(
            //
            //   primary: kSecondaryColor,
            // ),
            child: Text('حسناً'),
          ),
        ],
      ),
    ),
  );
}
