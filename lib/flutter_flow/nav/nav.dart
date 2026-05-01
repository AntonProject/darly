import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => RootPageContext.wrap(
        appStateNotifier.loggedIn ? SplashPageWidget() : StartPageWidget(),
        errorRoute: state.uri.toString(),
      ),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => RootPageContext.wrap(
            appStateNotifier.loggedIn ? SplashPageWidget() : StartPageWidget(),
          ),
        ),
        FFRoute(
          name: HomePageWidget.routeName,
          path: HomePageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => HomePageWidget(),
        ),
        FFRoute(
          name: SplashPageWidget.routeName,
          path: SplashPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SplashPageWidget(),
        ),
        FFRoute(
          name: StartPageWidget.routeName,
          path: StartPageWidget.routePath,
          builder: (context, params) => StartPageWidget(),
        ),
        FFRoute(
          name: SignUpWidget.routeName,
          path: SignUpWidget.routePath,
          builder: (context, params) => SignUpWidget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: ResetPasswordWidget.routeName,
          path: ResetPasswordWidget.routePath,
          builder: (context, params) => ResetPasswordWidget(),
        ),
        FFRoute(
          name: ResetPasswordEmailSentWidget.routeName,
          path: ResetPasswordEmailSentWidget.routePath,
          builder: (context, params) => ResetPasswordEmailSentWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AboutYouWidget.routeName,
          path: AboutYouWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AboutYouWidget(),
        ),
        FFRoute(
          name: ProfilePageWidget.routeName,
          path: ProfilePageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ProfilePageWidget(),
        ),
        FFRoute(
          name: ProfileEditPageWidget.routeName,
          path: ProfileEditPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ProfileEditPageWidget(),
        ),
        FFRoute(
          name: EditPasswordWidget.routeName,
          path: EditPasswordWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditPasswordWidget(),
        ),
        FFRoute(
          name: EditPasswordSuccessWidget.routeName,
          path: EditPasswordSuccessWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditPasswordSuccessWidget(),
        ),
        FFRoute(
          name: AboutAppPageWidget.routeName,
          path: AboutAppPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AboutAppPageWidget(),
        ),
        FFRoute(
          name: SupportPageWidget.routeName,
          path: SupportPageWidget.routePath,
          builder: (context, params) => SupportPageWidget(),
        ),
        FFRoute(
          name: NotificationPageWidget.routeName,
          path: NotificationPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => NotificationPageWidget(),
        ),
        FFRoute(
          name: NewsPageWidget.routeName,
          path: NewsPageWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'news': getDoc(['news'], NewsRecord.fromSnapshot),
          },
          builder: (context, params) => NewsPageWidget(
            news: params.getParam(
              'news',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: MessageLetterPageWidget.routeName,
          path: MessageLetterPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MessageLetterPageWidget(
            message: params.getParam(
              'message',
              ParamType.String,
            ),
            messageImg: params.getParam(
              'messageImg',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: VideoPageWidget.routeName,
          path: VideoPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => VideoPageWidget(),
        ),
        FFRoute(
          name: MetaCardPageWidget.routeName,
          path: MetaCardPageWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'metaCard': getDoc(['metaCards'], MetaCardsRecord.fromSnapshot),
          },
          builder: (context, params) => MetaCardPageWidget(
            metaCard: params.getParam(
              'metaCard',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: CalendarStartWidget.routeName,
          path: CalendarStartWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CalendarStartWidget(
            calendar: params.getParam(
              'calendar',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['calendar'],
            ),
          ),
        ),
        FFRoute(
          name: CalendarPageWidget.routeName,
          path: CalendarPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CalendarPageWidget(
            calendarUser: params.getParam(
              'calendarUser',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['calendar'],
            ),
          ),
        ),
        FFRoute(
          name: AudioPageWidget.routeName,
          path: AudioPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AudioPageWidget(),
        ),
        FFRoute(
          name: AudioWishWidget.routeName,
          path: AudioWishWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'audioList': getDocList(['audio'], AudioRecord.fromSnapshot),
          },
          builder: (context, params) => AudioWishWidget(
            audioList: params.getParam<AudioRecord>(
              'audioList',
              ParamType.Document,
              isList: true,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AudioExclWidget.routeName,
          path: AudioExclWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'audioList': getDocList(['audio'], AudioRecord.fromSnapshot),
          },
          builder: (context, params) => AudioExclWidget(
            audioList: params.getParam<AudioRecord>(
              'audioList',
              ParamType.Document,
              isList: true,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AudioPlayerWidget.routeName,
          path: AudioPlayerWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'currentTrack': getDoc(['audio'], AudioRecord.fromSnapshot),
            'audioFiles': getDocList(['audio'], AudioRecord.fromSnapshot),
          },
          builder: (context, params) => AudioPlayerWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            currentTrack: params.getParam(
              'currentTrack',
              ParamType.Document,
            ),
            audioFiles: params.getParam<AudioRecord>(
              'audioFiles',
              ParamType.Document,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: ChatPageWidget.routeName,
          path: ChatPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChatPageWidget(
            presset: params.getParam(
              'presset',
              ParamType.String,
            ),
            chat: params.getParam(
              'chat',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['chats'],
            ),
          ),
        ),
        FFRoute(
          name: CloudPaymentPageWidget.routeName,
          path: CloudPaymentPageWidget.routePath,
          builder: (context, params) => CloudPaymentPageWidget(
            orderRef: params.getParam(
              'orderRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['order'],
            ),
          ),
        ),
        FFRoute(
          name: PaymentPageWidget.routeName,
          path: PaymentPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => PaymentPageWidget(),
        ),
        FFRoute(
          name: EducationPageWidget.routeName,
          path: EducationPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EducationPageWidget(),
        ),
        FFRoute(
          name: VideoPlayerWidget.routeName,
          path: VideoPlayerWidget.routePath,
          builder: (context, params) => VideoPlayerWidget(
            urltoPath: params.getParam(
              'urltoPath',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EducationModulePageWidget.routeName,
          path: EducationModulePageWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'module': getDoc(
                ['education_modules'], EducationModulesRecord.fromSnapshot),
          },
          builder: (context, params) => EducationModulePageWidget(
            module: params.getParam(
              'module',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: EducationModuleLessonPageWidget.routeName,
          path: EducationModuleLessonPageWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'lesson': getDoc(['education_module_lessons'],
                EducationModuleLessonsRecord.fromSnapshot),
          },
          builder: (context, params) => EducationModuleLessonPageWidget(
            lesson: params.getParam(
              'lesson',
              ParamType.Document,
            ),
            count: params.getParam(
              'count',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: UpdateAppWidget.routeName,
          path: UpdateAppWidget.routePath,
          builder: (context, params) => UpdateAppWidget(),
        ),
        FFRoute(
          name: MetaCardSelectPageWidget.routeName,
          path: MetaCardSelectPageWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'cards': getDocList(['metaCards'], MetaCardsRecord.fromSnapshot),
          },
          builder: (context, params) => MetaCardSelectPageWidget(
            cards: params.getParam<MetaCardsRecord>(
              'cards',
              ParamType.Document,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: CalendarMonthsPageWidget.routeName,
          path: CalendarMonthsPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CalendarMonthsPageWidget(
            monthCyles: params.getParam<MonthCycleStruct>(
              'monthCyles',
              ParamType.DataStruct,
              isList: true,
              structBuilder: MonthCycleStruct.fromSerializableMap,
            ),
            calendarRef: params.getParam(
              'calendarRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['calendar'],
            ),
            duration: params.getParam(
              'duration',
              ParamType.int,
            ),
            length: params.getParam(
              'length',
              ParamType.int,
            ),
            fisrtdate: params.getParam(
              'fisrtdate',
              ParamType.DateTime,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/startPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/ezgif.com-webp-maker_(1).webp',
                    fit: BoxFit.cover,
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
