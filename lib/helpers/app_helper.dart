import 'package:appspector/appspector.dart';
import 'package:flutter/material.dart';

void runAppSpector() {
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
}

Future<void> showInfoDialogue({
  required BuildContext context,
  required String msg,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(content: Text(msg)),
  );
}
