import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? isWeb
          ? Container()
          : Container(
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/Page-Calendar.webp',
                fit: BoxFit.cover,
              ),
            )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'HomePage': ParameterData.none(),
  'splashPage': ParameterData.none(),
  'startPage': ParameterData.none(),
  'SignUp': ParameterData.none(),
  'Login': ParameterData.none(),
  'ResetPassword': ParameterData.none(),
  'ResetPasswordEmailSent': (data) async => ParameterData(
        allParams: {
          'email': getParameter<String>(data, 'email'),
        },
      ),
  'AboutYou': ParameterData.none(),
  'ProfilePage': ParameterData.none(),
  'ProfileEditPage': ParameterData.none(),
  'editPassword': ParameterData.none(),
  'editPasswordSuccess': ParameterData.none(),
  'aboutAppPage': ParameterData.none(),
  'SupportPage': ParameterData.none(),
  'NotificationPage': ParameterData.none(),
  'NewsPage': (data) async => ParameterData(
        allParams: {
          'news': await getDocumentParameter<NewsRecord>(
              data, 'news', NewsRecord.fromSnapshot),
        },
      ),
  'MessageLetterPageStart': ParameterData.none(),
  'VideoPage': ParameterData.none(),
  'MetaCardPage': (data) async => ParameterData(
        allParams: {
          'metaCard': await getDocumentParameter<MetaCardsRecord>(
              data, 'metaCard', MetaCardsRecord.fromSnapshot),
        },
      ),
  'CalendarStart': (data) async => ParameterData(
        allParams: {
          'calendar': getParameter<DocumentReference>(data, 'calendar'),
        },
      ),
  'CalendarPage': (data) async => ParameterData(
        allParams: {
          'calendarUser': getParameter<DocumentReference>(data, 'calendarUser'),
        },
      ),
  'AudioPage': ParameterData.none(),
  'AudioWish': (data) async => ParameterData(
        allParams: {
          'title': getParameter<String>(data, 'title'),
        },
      ),
  'AudioExcl': (data) async => ParameterData(
        allParams: {
          'title': getParameter<String>(data, 'title'),
        },
      ),
  'AudioPlayer': (data) async {
    final allParams = {
      'title': getParameter<String>(data, 'title'),
      'currentTrack': await getDocumentParameter<AudioRecord>(
          data, 'currentTrack', AudioRecord.fromSnapshot),
    };
    return ParameterData(
      requiredParams: {
        'title': serializeParam(
          allParams['title'],
          ParamType.String,
        ),
        'currentTrack': serializeParam(
          allParams['currentTrack'],
          ParamType.Document,
        ),
        'audioFiles': serializeParam(
          allParams['audioFiles'],
          ParamType.Document,
          isList: true,
        ),
      },
      allParams: allParams,
    );
  },
  'ChatPage': (data) async => ParameterData(
        allParams: {
          'presset': getParameter<String>(data, 'presset'),
          'chat': getParameter<DocumentReference>(data, 'chat'),
        },
      ),
  'CloudPaymentPage': (data) async => ParameterData(
        allParams: {
          'orderRef': getParameter<DocumentReference>(data, 'orderRef'),
        },
      ),
  'PaymentPage': ParameterData.none(),
  'EducationPage': ParameterData.none(),
  'videoPlayer': (data) async => ParameterData(
        allParams: {
          'urltoPath': getParameter<String>(data, 'urltoPath'),
        },
      ),
  'EducationModulePage': (data) async => ParameterData(
        allParams: {
          'module': await getDocumentParameter<EducationModulesRecord>(
              data, 'module', EducationModulesRecord.fromSnapshot),
        },
      ),
  'EducationModuleLessonPage': (data) async => ParameterData(
        allParams: {
          'lesson': await getDocumentParameter<EducationModuleLessonsRecord>(
              data, 'lesson', EducationModuleLessonsRecord.fromSnapshot),
          'count': getParameter<int>(data, 'count'),
        },
      ),
  'updateApp': ParameterData.none(),
  'MetaCardSelectPage': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'CalendarMonthsPage': (data) async => ParameterData(
        allParams: {
          'calendarRef': getParameter<DocumentReference>(data, 'calendarRef'),
          'duration': getParameter<int>(data, 'duration'),
          'length': getParameter<int>(data, 'length'),
          'fisrtdate': getParameter<DateTime>(data, 'fisrtdate'),
        },
      ),
  'MessageLetterPage': (data) async => ParameterData(
        allParams: {
          'message': getParameter<String>(data, 'message'),
          'messageImg': getParameter<String>(data, 'messageImg'),
        },
      ),
  'splashStartPage': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
