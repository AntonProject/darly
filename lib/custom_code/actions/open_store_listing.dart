// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:in_app_review/in_app_review.dart';

final InAppReview inAppReview = InAppReview.instance;

Future<void> openStoreListing() async {
  try {
    // Проверьте, доступен ли InAppReview
    if (await inAppReview.isAvailable()) {
      // Откройте страницу приложения в магазине
      await inAppReview.openStoreListing(appStoreId: 'storeID');
    } else {
      print('In-app review is not available');
    }
  } catch (e) {
    print('Error opening store listing: $e');
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
