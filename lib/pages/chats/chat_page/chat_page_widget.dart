import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/components/back_button/back_button_widget.dart';
import '/components/file_comp/file_comp_widget.dart';
import '/components/navbar/navbar_widget.dart';
import '/components/payment_chat_button/payment_chat_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/chats/chat_delete_dialog/chat_delete_dialog_widget.dart';
import '/pages/chats/chat_dialog_icon/chat_dialog_icon_widget.dart';
import '/pages/chats/empty_messages/empty_messages_widget.dart';
import '/pages/chats/image_expand/image_expand_widget.dart';
import '/web/navbar_web/navbar_web_widget.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'chat_page_model.dart';
export 'chat_page_model.dart';

class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({
    super.key,
    this.presset,
    this.chat,
  });

  final String? presset;
  final DocumentReference? chat;

  static String routeName = 'ChatPage';
  static String routePath = '/chatPage';

  @override
  State<ChatPageWidget> createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget>
    with TickerProviderStateMixin {
  late ChatPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ChatPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHAT_PAGE_PAGE_ChatPage_ON_INIT_STATE');
      await Future.wait([
        Future(() async {
          logFirebaseEvent('ChatPage_custom_action');
          unawaited(
            () async {
              await actions.setStatusBarColor();
            }(),
          );
          logFirebaseEvent('ChatPage_custom_action');
          unawaited(
            () async {
              await actions.lockLandscapeMode();
            }(),
          );
        }),
        Future(() async {
          if (widget!.presset != null && widget!.presset != '') {
            logFirebaseEvent('ChatPage_set_form_field');
            safeSetState(() {
              _model.messageFieldTextController?.text = widget!.presset!;
              _model.messageFieldFocusNode?.requestFocus();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _model.messageFieldTextController?.selection =
                    TextSelection.collapsed(
                  offset: _model.messageFieldTextController!.text.length,
                );
              });
            });
          }
        }),
        Future(() async {
          logFirebaseEvent('ChatPage_firestore_query');
          _model.messageCountQuery = await queryChatMessagesRecordCount(
            queryBuilder: (chatMessagesRecord) => chatMessagesRecord
                .where(
                  'created_by',
                  isEqualTo: currentUserUid,
                )
                .where(
                  'created_at',
                  isGreaterThanOrEqualTo: functions.startDay(),
                )
                .where(
                  'created_at',
                  isLessThanOrEqualTo: functions.endDay(),
                ),
          );
          logFirebaseEvent('ChatPage_update_page_state');
          _model.messagesCount = _model.messageCountQuery;
          safeSetState(() {});
        }),
        Future(() async {
          if (widget!.chat != null) {
            logFirebaseEvent('ChatPage_update_app_state');
            FFAppState().chatRef = FFAppState().chatRef;
            safeSetState(() {});
          } else {
            logFirebaseEvent('ChatPage_firestore_query');
            _model.chatsUser = await queryChatsRecordCount(
              queryBuilder: (chatsRecord) => chatsRecord.where(
                'created_by',
                isEqualTo: currentUserUid,
              ),
            );
            logFirebaseEvent('ChatPage_update_page_state');
            _model.chatsUserCount = valueOrDefault<int>(
              _model.chatsUser,
              0,
            );
            safeSetState(() {});
          }
        }),
        Future(() async {
          logFirebaseEvent('ChatPage_firestore_query');
          _model.chatsCount = await queryChatsRecordCount(
            queryBuilder: (chatsRecord) => chatsRecord.where(
              'created_by',
              isEqualTo: currentUserUid,
            ),
          );
          logFirebaseEvent('ChatPage_update_page_state');
          _model.chatsUserCount = valueOrDefault<int>(
            _model.chatsCount,
            0,
          );
          safeSetState(() {});
        }),
        Future(() async {
          logFirebaseEvent('ChatPage_update_page_state');
          _model.isTyping = false;
          safeSetState(() {});
        }),
      ]);
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.messageFieldTextController ??= TextEditingController();
    _model.messageFieldFocusNode ??= FocusNode();
    _model.messageFieldFocusNode!.addListener(() => safeSetState(() {}));
    _model.messageFieldNewChatTextController ??= TextEditingController();
    _model.messageFieldNewChatFocusNode ??= FocusNode();
    _model.messageFieldNewChatFocusNode!.addListener(() => safeSetState(() {}));
    animationsMap.addAll({
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 1000.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Title(
        title: 'ChatPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (isWeb &&
                        responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                        ))
                      wrapWithModel(
                        model: _model.navbarWebModel,
                        updateCallback: () => safeSetState(() {}),
                        updateOnChange: true,
                        child: NavbarWebWidget(
                          pageNum: 2.0,
                        ),
                      ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/Background.webp',
                              ).image,
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            children: [
                              Stack(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                children: [
                                  Builder(
                                    builder: (context) {
                                      if (FFAppState().chatRef != null) {
                                        return StreamBuilder<
                                            List<ChatMessagesRecord>>(
                                          stream: queryChatMessagesRecord(
                                            queryBuilder:
                                                (chatMessagesRecord) =>
                                                    chatMessagesRecord
                                                        .where(
                                                          'chatRef',
                                                          isEqualTo:
                                                              FFAppState()
                                                                  .chatRef,
                                                        )
                                                        .orderBy('created_at',
                                                            descending: true),
                                          )..listen((snapshot) {
                                              List<ChatMessagesRecord>
                                                  containerChatMessagesRecordList =
                                                  snapshot;
                                              if (_model.containerPreviousSnapshot !=
                                                      null &&
                                                  !const ListEquality(
                                                          ChatMessagesRecordDocumentEquality())
                                                      .equals(
                                                          containerChatMessagesRecordList,
                                                          _model
                                                              .containerPreviousSnapshot)) {
                                                () async {
                                                  logFirebaseEvent(
                                                      'CHAT_Container_311w7m1u_ON_DATA_CHANGE');

                                                  safeSetState(() {});
                                                }();
                                              }
                                              _model.containerPreviousSnapshot =
                                                  snapshot;
                                            }),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<ChatMessagesRecord>
                                                containerChatMessagesRecordList =
                                                snapshot.data!;

                                            return Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  1.0,
                                              constraints: BoxConstraints(
                                                maxWidth: 800.0,
                                              ),
                                              decoration: BoxDecoration(),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Builder(
                                                  builder: (context) {
                                                    final messages =
                                                        containerChatMessagesRecordList
                                                            .toList();
                                                    if (messages.isEmpty) {
                                                      return EmptyMessagesWidget(
                                                        emptyField: _model
                                                                    .messageFieldTextController
                                                                    .text ==
                                                                null ||
                                                            _model.messageFieldTextController
                                                                    .text ==
                                                                '',
                                                        messageCount: _model
                                                            .messagesCount!,
                                                        setPresset:
                                                            (title) async {
                                                          logFirebaseEvent(
                                                              'CHAT_ListView_vwlp1iw6_CALLBACK');
                                                          logFirebaseEvent(
                                                              'ListView_set_form_field');
                                                          safeSetState(() {
                                                            _model.messageFieldTextController
                                                                    ?.text =
                                                                FFAppState()
                                                                    .pressetChat;
                                                            _model
                                                                .messageFieldFocusNode
                                                                ?.requestFocus();
                                                            WidgetsBinding
                                                                .instance
                                                                .addPostFrameCallback(
                                                                    (_) {
                                                              _model.messageFieldTextController
                                                                      ?.selection =
                                                                  TextSelection
                                                                      .collapsed(
                                                                offset: _model
                                                                    .messageFieldTextController!
                                                                    .text
                                                                    .length,
                                                              );
                                                            });
                                                          });
                                                        },
                                                      );
                                                    }

                                                    return ListView.separated(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                        0,
                                                        180.0,
                                                        0,
                                                        valueOrDefault<double>(
                                                          (isWeb
                                                                  ? MediaQuery.viewInsetsOf(
                                                                              context)
                                                                          .bottom >
                                                                      0
                                                                  : _isKeyboardVisible)
                                                              ? 140.0
                                                              : valueOrDefault<
                                                                  double>(
                                                                  valueOrDefault<
                                                                          bool>(
                                                                    (_model.messagesCount! >=
                                                                            10) &&
                                                                        !valueOrDefault<
                                                                            bool>(
                                                                          functions
                                                                              .dateGreatherThanToday(currentUserDocument?.subscriptionExpDate),
                                                                          false,
                                                                        ) &&
                                                                        () {
                                                                          if (isiOS) {
                                                                            return !valueOrDefault<bool>(
                                                                              functions.checkVersionReview(FFAppState().version, getRemoteConfigString('appleReviewVersion')),
                                                                              false,
                                                                            );
                                                                          } else if (isAndroid) {
                                                                            return !valueOrDefault<bool>(
                                                                              functions.checkVersionReview(FFAppState().version, getRemoteConfigString('googleReviewVersion')),
                                                                              false,
                                                                            );
                                                                          } else {
                                                                            return true;
                                                                          }
                                                                        }(),
                                                                    false,
                                                                  )
                                                                      ? 240.0
                                                                      : 192.0,
                                                                  192.0,
                                                                ),
                                                          192.0,
                                                        ),
                                                      ),
                                                      reverse: true,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          messages.length,
                                                      separatorBuilder:
                                                          (_, __) => SizedBox(
                                                              height: 20.0),
                                                      itemBuilder: (context,
                                                          messagesIndex) {
                                                        final messagesItem =
                                                            messages[
                                                                messagesIndex];
                                                        return Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 1.0),
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  if (messagesItem
                                                                          .role ==
                                                                      'user')
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                      child:
                                                                          Container(
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          minWidth:
                                                                              MediaQuery.sizeOf(context).width * 0.2,
                                                                          maxWidth:
                                                                              MediaQuery.sizeOf(context).width * 0.7,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).white12,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(12.0),
                                                                            topRight:
                                                                                Radius.circular(12.0),
                                                                            bottomLeft:
                                                                                Radius.circular(12.0),
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children: [
                                                                              if (messagesItem.text != null && messagesItem.text != '')
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                                                                                  child: Container(
                                                                                    width: null,
                                                                                    height: null,
                                                                                    child: custom_widgets.CustomMarkdown(
                                                                                      width: null,
                                                                                      height: null,
                                                                                      textSize: 16.0,
                                                                                      textWeight: 400.0,
                                                                                      boldTextSize: 16.0,
                                                                                      boldTextWeight: 400.0,
                                                                                      textColor: FlutterFlowTheme.of(context).primaryText,
                                                                                      text: messagesItem.text,
                                                                                      role: messagesItem.role,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (messagesItem.file.path != null && messagesItem.file.path != '')
                                                                                FileCompWidget(
                                                                                  key: Key('Key0so_${messagesIndex}_of_${messages.length}'),
                                                                                  fileURL: messagesItem.file.path,
                                                                                ),
                                                                              if (messagesItem.image != null && messagesItem.image != '')
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    logFirebaseEvent('CHAT_PAGE_PAGE_Image_h2u0gzhp_ON_TAP');
                                                                                    logFirebaseEvent('Image_bottom_sheet');
                                                                                    showModalBottomSheet(
                                                                                      isScrollControlled: true,
                                                                                      backgroundColor: Colors.transparent,
                                                                                      isDismissible: false,
                                                                                      enableDrag: false,
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return WebViewAware(
                                                                                          child: GestureDetector(
                                                                                            onTap: () {
                                                                                              FocusScope.of(context).unfocus();
                                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                                            },
                                                                                            child: Padding(
                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                              child: ImageExpandWidget(
                                                                                                image: messagesItem.image,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ).then((value) => safeSetState(() {}));
                                                                                  },
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(16.0),
                                                                                    child: CachedNetworkImage(
                                                                                      fadeInDuration: Duration(milliseconds: 500),
                                                                                      fadeOutDuration: Duration(milliseconds: 500),
                                                                                      imageUrl: getCORSProxyUrl(
                                                                                        messagesItem.image,
                                                                                      ),
                                                                                      width: 160.0,
                                                                                      height: 160.0,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (messagesItem
                                                                          .role !=
                                                                      'user')
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          if (messagesItem.text != null &&
                                                                              messagesItem.text != '')
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onLongPress: () async {
                                                                                logFirebaseEvent('CHAT_Container_lysgs9q3_ON_LONG_PRESS');
                                                                                logFirebaseEvent('CustomMarkdown_copy_to_clipboard');
                                                                                await Clipboard.setData(ClipboardData(text: messagesItem.text));
                                                                                logFirebaseEvent('CustomMarkdown_show_snack_bar');
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text(
                                                                                      'Скопировано в буфер обмена',
                                                                                      style: TextStyle(
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontSize: 15.0,
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                    duration: Duration(milliseconds: 2000),
                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                width: null,
                                                                                height: null,
                                                                                child: custom_widgets.CustomMarkdown(
                                                                                  width: null,
                                                                                  height: null,
                                                                                  textSize: 16.0,
                                                                                  textWeight: 400.0,
                                                                                  boldTextSize: 16.0,
                                                                                  boldTextWeight: 400.0,
                                                                                  textColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  text: messagesItem.text,
                                                                                  role: messagesItem.role,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          if (messagesItem.image != null &&
                                                                              messagesItem.image != '')
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                logFirebaseEvent('CHAT_PAGE_PAGE_Image_e101jing_ON_TAP');
                                                                                logFirebaseEvent('Image_bottom_sheet');
                                                                                showModalBottomSheet(
                                                                                  isScrollControlled: true,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  isDismissible: false,
                                                                                  enableDrag: false,
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return WebViewAware(
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          FocusScope.of(context).unfocus();
                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                        },
                                                                                        child: Padding(
                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                          child: ImageExpandWidget(
                                                                                            image: messagesItem.image,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ).then((value) => safeSetState(() {}));
                                                                              },
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                                child: CachedNetworkImage(
                                                                                  fadeInDuration: Duration(milliseconds: 500),
                                                                                  fadeOutDuration: Duration(milliseconds: 500),
                                                                                  imageUrl: getCORSProxyUrl(
                                                                                    messagesItem.image,
                                                                                  ),
                                                                                  width: 160.0,
                                                                                  height: 160.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  logFirebaseEvent('CHAT_PAGE_PAGE_Icon_jxucdfco_ON_TAP');
                                                                                  logFirebaseEvent('Icon_copy_to_clipboard');
                                                                                  await Clipboard.setData(ClipboardData(text: messagesItem.text));
                                                                                  logFirebaseEvent('Icon_show_snack_bar');
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        'Скопировано в буфер обмена',
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              letterSpacing: 0.0,
                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
                                                                                            ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 3000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.content_copy_rounded,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 16.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  if (valueOrDefault<
                                                                          bool>(
                                                                        _model
                                                                            .isTyping,
                                                                        false,
                                                                      ) &&
                                                                      (messagesItem
                                                                              .reference ==
                                                                          containerChatMessagesRecordList
                                                                              .firstOrNull
                                                                              ?.reference) &&
                                                                      (containerChatMessagesRecordList
                                                                              .firstOrNull
                                                                              ?.role ==
                                                                          'user'))
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            12.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                              child: Image.asset(
                                                                                'assets/images/aiType.png',
                                                                                width: 24.0,
                                                                                height: 24.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
                                                                            Expanded(
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: null,
                                                                                child: custom_widgets.TypewriterLoop(
                                                                                  width: double.infinity,
                                                                                  height: null,
                                                                                  text: 'Дайте-ка подумать...',
                                                                                  typingSpeed: 90,
                                                                                  pauseAfterComplete: 600,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 4.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ).animateOnPageLoad(
                                                                  animationsMap[
                                                                      'columnOnPageLoadAnimation1']!),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return wrapWithModel(
                                          model: _model.emptyMessagesModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          updateOnChange: true,
                                          child: EmptyMessagesWidget(
                                            emptyField: _model
                                                        .messageFieldTextController
                                                        .text ==
                                                    null ||
                                                _model.messageFieldTextController
                                                        .text ==
                                                    '',
                                            messageCount: _model.messagesCount!,
                                            setPresset: (title) async {
                                              logFirebaseEvent(
                                                  'CHAT_Container_vwhcw5fe_CALLBACK');
                                              logFirebaseEvent(
                                                  'emptyMessages_set_form_field');
                                              safeSetState(() {
                                                _model.messageFieldTextController
                                                        ?.text =
                                                    FFAppState().pressetChat;
                                              });
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (valueOrDefault<bool>(
                                        (_model.messagesCount! >= 10) &&
                                            !valueOrDefault<bool>(
                                              functions.dateGreatherThanToday(
                                                  currentUserDocument
                                                      ?.subscriptionExpDate),
                                              false,
                                            ) &&
                                            () {
                                              if (isiOS) {
                                                return !valueOrDefault<bool>(
                                                  functions.checkVersionReview(
                                                      FFAppState().version,
                                                      getRemoteConfigString(
                                                          'appleReviewVersion')),
                                                  false,
                                                );
                                              } else if (isAndroid) {
                                                return !valueOrDefault<bool>(
                                                  functions.checkVersionReview(
                                                      FFAppState().version,
                                                      getRemoteConfigString(
                                                          'googleReviewVersion')),
                                                  false,
                                                );
                                              } else {
                                                return true;
                                              }
                                            }(),
                                        false,
                                      )) {
                                        return Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 800.0,
                                          ),
                                          decoration: BoxDecoration(),
                                          child: wrapWithModel(
                                            model:
                                                _model.paymentChatButtonModel1,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: PaymentChatButtonWidget(),
                                          ),
                                        );
                                      } else {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 1.0,
                                              sigmaY: 3.0,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0,
                                                      0.0,
                                                      20.0,
                                                      valueOrDefault<double>(
                                                        () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall) {
                                                            return valueOrDefault<
                                                                double>(
                                                              (isWeb
                                                                      ? MediaQuery.viewInsetsOf(context)
                                                                              .bottom >
                                                                          0
                                                                      : _isKeyboardVisible)
                                                                  ? 12.0
                                                                  : 120.0,
                                                              120.0,
                                                            );
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointMedium) {
                                                            return valueOrDefault<
                                                                double>(
                                                              (isWeb
                                                                      ? MediaQuery.viewInsetsOf(context)
                                                                              .bottom >
                                                                          0
                                                                      : _isKeyboardVisible)
                                                                  ? 12.0
                                                                  : 120.0,
                                                              120.0,
                                                            );
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointLarge) {
                                                            return 24.0;
                                                          } else {
                                                            return 24.0;
                                                          }
                                                        }(),
                                                        24.0,
                                                      )),
                                              child: Container(
                                                width: double.infinity,
                                                constraints: BoxConstraints(
                                                  maxWidth: 800.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .white12,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 24.0,
                                                      color: Color(0x1F2A2929),
                                                      offset: Offset(
                                                        0.0,
                                                        4.0,
                                                      ),
                                                      spreadRadius: 0.0,
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .white12,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .messageFieldTextController,
                                                          focusNode: _model
                                                              .messageFieldFocusNode,
                                                          onChanged: (_) =>
                                                              EasyDebounce
                                                                  .debounce(
                                                            '_model.messageFieldTextController',
                                                            Duration(
                                                                milliseconds:
                                                                    50),
                                                            () => safeSetState(
                                                                () {}),
                                                          ),
                                                          onFieldSubmitted:
                                                              (_) async {
                                                            logFirebaseEvent(
                                                                'CHAT_messageField_ON_TEXTFIELD_SUBMIT');
                                                            var _shouldSetState =
                                                                false;
                                                            if (_model.messageFieldTextController
                                                                        .text !=
                                                                    null &&
                                                                _model.messageFieldTextController
                                                                        .text !=
                                                                    '') {
                                                              logFirebaseEvent(
                                                                  'messageField_update_app_state');
                                                              FFAppState()
                                                                  .pressetChat = '';
                                                              safeSetState(
                                                                  () {});
                                                              logFirebaseEvent(
                                                                  'messageField_update_page_state');
                                                              _model.message =
                                                                  _model
                                                                      .messageFieldTextController
                                                                      .text;
                                                              safeSetState(
                                                                  () {});
                                                              logFirebaseEvent(
                                                                  'messageField_custom_action');
                                                              unawaited(
                                                                () async {
                                                                  await actions
                                                                      .closeKeyboard(
                                                                    context,
                                                                  );
                                                                }(),
                                                              );
                                                              logFirebaseEvent(
                                                                  'messageField_clear_text_fields_pin_codes');
                                                              safeSetState(() {
                                                                _model
                                                                    .messageFieldTextController
                                                                    ?.clear();
                                                                _model
                                                                    .messageFieldNewChatTextController
                                                                    ?.clear();
                                                              });
                                                              if ((FFAppState()
                                                                          .chatRef ==
                                                                      null) ||
                                                                  (FFAppState()
                                                                              .chatId ==
                                                                          null ||
                                                                      FFAppState()
                                                                              .chatId ==
                                                                          '')) {
                                                                logFirebaseEvent(
                                                                    'messageField_backend_call');
                                                                _model.newChatAPI =
                                                                    await ChatAssistantGroup
                                                                        .chatIdCall
                                                                        .call(
                                                                  userId:
                                                                      currentUserUid,
                                                                );

                                                                _shouldSetState =
                                                                    true;
                                                                if ((_model
                                                                        .newChatAPI
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  logFirebaseEvent(
                                                                      'messageField_backend_call');

                                                                  var chatsRecordReference =
                                                                      ChatsRecord
                                                                          .collection
                                                                          .doc();
                                                                  await chatsRecordReference
                                                                      .set(
                                                                          createChatsRecordData(
                                                                    createdBy:
                                                                        currentUserUid,
                                                                    createdAt:
                                                                        getCurrentTimestamp,
                                                                    title: (String
                                                                        text) {
                                                                      return text
                                                                              .isEmpty
                                                                          ? ' '
                                                                          : text[0].toUpperCase() +
                                                                              text.substring(1);
                                                                    }(_model
                                                                        .message!),
                                                                    chatId: ChatAssistantGroup
                                                                        .chatIdCall
                                                                        .chatId(
                                                                      (_model.newChatAPI
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    ),
                                                                  ));
                                                                  _model.newChatField1 =
                                                                      ChatsRecord.getDocumentFromData(
                                                                          createChatsRecordData(
                                                                            createdBy:
                                                                                currentUserUid,
                                                                            createdAt:
                                                                                getCurrentTimestamp,
                                                                            title:
                                                                                (String text) {
                                                                              return text.isEmpty ? ' ' : text[0].toUpperCase() + text.substring(1);
                                                                            }(_model.message!),
                                                                            chatId:
                                                                                ChatAssistantGroup.chatIdCall.chatId(
                                                                              (_model.newChatAPI?.jsonBody ?? ''),
                                                                            ),
                                                                          ),
                                                                          chatsRecordReference);
                                                                  _shouldSetState =
                                                                      true;
                                                                  logFirebaseEvent(
                                                                      'messageField_update_app_state');
                                                                  FFAppState()
                                                                          .chatRef =
                                                                      _model
                                                                          .newChatField1
                                                                          ?.reference;
                                                                  FFAppState()
                                                                          .chatId =
                                                                      ChatAssistantGroup
                                                                          .chatIdCall
                                                                          .chatId(
                                                                    (_model.newChatAPI
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  )!;
                                                                  safeSetState(
                                                                      () {});
                                                                  logFirebaseEvent(
                                                                      'messageField_update_page_state');
                                                                  _model.chatsUserCount =
                                                                      _model.chatsUserCount +
                                                                          1;
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  logFirebaseEvent(
                                                                      'messageField_show_snack_bar');
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        (_model.newChatAPI?.bodyText ??
                                                                            ''),
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondary,
                                                                    ),
                                                                  );
                                                                  if (_shouldSetState)
                                                                    safeSetState(
                                                                        () {});
                                                                  return;
                                                                }
                                                              }
                                                              logFirebaseEvent(
                                                                  'messageField_backend_call');

                                                              var chatMessagesRecordReference =
                                                                  ChatMessagesRecord
                                                                      .collection
                                                                      .doc();
                                                              await chatMessagesRecordReference
                                                                  .set(
                                                                      createChatMessagesRecordData(
                                                                createdBy:
                                                                    currentUserUid,
                                                                createdAt:
                                                                    getCurrentTimestamp,
                                                                text: _model
                                                                    .message,
                                                                chatRef:
                                                                    FFAppState()
                                                                        .chatRef,
                                                                role: 'user',
                                                              ));
                                                              _model.createMessageField =
                                                                  ChatMessagesRecord
                                                                      .getDocumentFromData(
                                                                          createChatMessagesRecordData(
                                                                            createdBy:
                                                                                currentUserUid,
                                                                            createdAt:
                                                                                getCurrentTimestamp,
                                                                            text:
                                                                                _model.message,
                                                                            chatRef:
                                                                                FFAppState().chatRef,
                                                                            role:
                                                                                'user',
                                                                          ),
                                                                          chatMessagesRecordReference);
                                                              _shouldSetState =
                                                                  true;
                                                              await Future
                                                                  .wait([
                                                                Future(
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'messageField_update_page_state');
                                                                  _model.isTyping =
                                                                      true;
                                                                  _model.messagesCount =
                                                                      _model.messagesCount! +
                                                                          1;
                                                                  safeSetState(
                                                                      () {});
                                                                  logFirebaseEvent(
                                                                      'messageField_wait__delay');
                                                                  await Future
                                                                      .delayed(
                                                                    Duration(
                                                                      milliseconds:
                                                                          5000,
                                                                    ),
                                                                  );
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'messageField_cloud_function');
                                                                  try {
                                                                    final result = await FirebaseFunctions
                                                                        .instance
                                                                        .httpsCallable(
                                                                            'chatMessageStream')
                                                                        .call({
                                                                      "chatId":
                                                                          FFAppState()
                                                                              .chatId,
                                                                      "message":
                                                                          _model
                                                                              .message!,
                                                                      "chatRefId":
                                                                          FFAppState()
                                                                              .chatRef!
                                                                              .id,
                                                                      "userId":
                                                                          currentUserUid,
                                                                    });
                                                                    _model.chatMessField =
                                                                        ChatMessageStreamCloudFunctionCallResponse(
                                                                      succeeded:
                                                                          true,
                                                                    );
                                                                  } on FirebaseFunctionsException catch (error) {
                                                                    _model.chatMessField =
                                                                        ChatMessageStreamCloudFunctionCallResponse(
                                                                      errorCode:
                                                                          error
                                                                              .code,
                                                                      succeeded:
                                                                          false,
                                                                    );
                                                                  }

                                                                  _shouldSetState =
                                                                      true;
                                                                }),
                                                              ]);
                                                              logFirebaseEvent(
                                                                  'messageField_update_page_state');
                                                              _model.message =
                                                                  null;
                                                              _model.isTyping =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }

                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                          },
                                                          autofocus: false,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .send,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: false,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelMediumFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .labelMediumIsCustom,
                                                                    ),
                                                            hintText:
                                                                'Спроси что-нибудь...',
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                      lineHeight:
                                                                          1.25,
                                                                    ),
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            errorBorder:
                                                                InputBorder
                                                                    .none,
                                                            focusedErrorBorder:
                                                                InputBorder
                                                                    .none,
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight:
                                                                    1.25,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                          maxLines: 10,
                                                          minLines: 1,
                                                          cursorColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          enableInteractiveSelection:
                                                              true,
                                                          validator: _model
                                                              .messageFieldTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  2.0,
                                                                  4.0,
                                                                  4.0),
                                                      child:
                                                          FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 99.0,
                                                        buttonSize: 40.0,
                                                        fillColor:
                                                            valueOrDefault<
                                                                Color>(
                                                          _model.messageFieldTextController
                                                                          .text ==
                                                                      null ||
                                                                  _model.messageFieldTextController
                                                                          .text ==
                                                                      ''
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .white24
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .white24,
                                                        ),
                                                        disabledColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .white24,
                                                        icon: Icon(
                                                          FFIcons.karrowUp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        onPressed: (_model
                                                                        .messageFieldTextController
                                                                        .text ==
                                                                    null ||
                                                                _model.messageFieldTextController
                                                                        .text ==
                                                                    '')
                                                            ? null
                                                            : () async {
                                                                logFirebaseEvent(
                                                                    'CHAT_PAGE_PAGE_IconButtonSend_ON_TAP');
                                                                var _shouldSetState =
                                                                    false;
                                                                if (_model.messageFieldTextController
                                                                            .text !=
                                                                        null &&
                                                                    _model.messageFieldTextController
                                                                            .text !=
                                                                        '') {
                                                                  logFirebaseEvent(
                                                                      'IconButtonSend_update_app_state');
                                                                  FFAppState()
                                                                      .pressetChat = '';
                                                                  safeSetState(
                                                                      () {});
                                                                  logFirebaseEvent(
                                                                      'IconButtonSend_update_page_state');
                                                                  _model.message =
                                                                      _model
                                                                          .messageFieldTextController
                                                                          .text;
                                                                  safeSetState(
                                                                      () {});
                                                                  logFirebaseEvent(
                                                                      'IconButtonSend_custom_action');
                                                                  unawaited(
                                                                    () async {
                                                                      await actions
                                                                          .closeKeyboard(
                                                                        context,
                                                                      );
                                                                    }(),
                                                                  );
                                                                  logFirebaseEvent(
                                                                      'IconButtonSend_clear_text_fields_pin_cod');
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .messageFieldTextController
                                                                        ?.clear();
                                                                    _model
                                                                        .messageFieldNewChatTextController
                                                                        ?.clear();
                                                                  });
                                                                  if ((FFAppState()
                                                                              .chatRef ==
                                                                          null) ||
                                                                      (FFAppState().chatId ==
                                                                              null ||
                                                                          FFAppState().chatId ==
                                                                              '')) {
                                                                    logFirebaseEvent(
                                                                        'IconButtonSend_backend_call');
                                                                    _model.newChatAPIbutton =
                                                                        await ChatAssistantGroup
                                                                            .chatIdCall
                                                                            .call(
                                                                      userId:
                                                                          currentUserUid,
                                                                    );

                                                                    _shouldSetState =
                                                                        true;
                                                                    if ((_model
                                                                            .newChatAPIbutton
                                                                            ?.succeeded ??
                                                                        true)) {
                                                                      logFirebaseEvent(
                                                                          'IconButtonSend_backend_call');

                                                                      var chatsRecordReference = ChatsRecord
                                                                          .collection
                                                                          .doc();
                                                                      await chatsRecordReference
                                                                          .set(
                                                                              createChatsRecordData(
                                                                        createdBy:
                                                                            currentUserUid,
                                                                        createdAt:
                                                                            getCurrentTimestamp,
                                                                        title: (String
                                                                            text) {
                                                                          return text.isEmpty
                                                                              ? ' '
                                                                              : text[0].toUpperCase() + text.substring(1);
                                                                        }(_model
                                                                            .message!),
                                                                        chatId: ChatAssistantGroup
                                                                            .chatIdCall
                                                                            .chatId(
                                                                          (_model.newChatAPIbutton?.jsonBody ??
                                                                              ''),
                                                                        ),
                                                                      ));
                                                                      _model.newChatButton1 = ChatsRecord.getDocumentFromData(
                                                                          createChatsRecordData(
                                                                            createdBy:
                                                                                currentUserUid,
                                                                            createdAt:
                                                                                getCurrentTimestamp,
                                                                            title:
                                                                                (String text) {
                                                                              return text.isEmpty ? ' ' : text[0].toUpperCase() + text.substring(1);
                                                                            }(_model.message!),
                                                                            chatId:
                                                                                ChatAssistantGroup.chatIdCall.chatId(
                                                                              (_model.newChatAPIbutton?.jsonBody ?? ''),
                                                                            ),
                                                                          ),
                                                                          chatsRecordReference);
                                                                      _shouldSetState =
                                                                          true;
                                                                      logFirebaseEvent(
                                                                          'IconButtonSend_update_app_state');
                                                                      FFAppState()
                                                                              .chatRef =
                                                                          _model
                                                                              .newChatButton1
                                                                              ?.reference;
                                                                      FFAppState()
                                                                              .chatId =
                                                                          ChatAssistantGroup
                                                                              .chatIdCall
                                                                              .chatId(
                                                                        (_model.newChatAPIbutton?.jsonBody ??
                                                                            ''),
                                                                      )!;
                                                                      safeSetState(
                                                                          () {});
                                                                      logFirebaseEvent(
                                                                          'IconButtonSend_update_page_state');
                                                                      _model.chatsUserCount =
                                                                          _model.chatsUserCount +
                                                                              1;
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      logFirebaseEvent(
                                                                          'IconButtonSend_show_snack_bar');
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            (_model.newChatAPIbutton?.bodyText ??
                                                                                ''),
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                            ),
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 4000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                        ),
                                                                      );
                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                      return;
                                                                    }
                                                                  }
                                                                  logFirebaseEvent(
                                                                      'IconButtonSend_backend_call');

                                                                  var chatMessagesRecordReference =
                                                                      ChatMessagesRecord
                                                                          .collection
                                                                          .doc();
                                                                  await chatMessagesRecordReference
                                                                      .set(
                                                                          createChatMessagesRecordData(
                                                                    createdBy:
                                                                        currentUserUid,
                                                                    createdAt:
                                                                        getCurrentTimestamp,
                                                                    text: _model
                                                                        .message,
                                                                    chatRef:
                                                                        FFAppState()
                                                                            .chatRef,
                                                                    role:
                                                                        'user',
                                                                  ));
                                                                  _model.createMessageButton =
                                                                      ChatMessagesRecord.getDocumentFromData(
                                                                          createChatMessagesRecordData(
                                                                            createdBy:
                                                                                currentUserUid,
                                                                            createdAt:
                                                                                getCurrentTimestamp,
                                                                            text:
                                                                                _model.message,
                                                                            chatRef:
                                                                                FFAppState().chatRef,
                                                                            role:
                                                                                'user',
                                                                          ),
                                                                          chatMessagesRecordReference);
                                                                  _shouldSetState =
                                                                      true;
                                                                  await Future
                                                                      .wait([
                                                                    Future(
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'IconButtonSend_update_page_state');
                                                                      _model.isTyping =
                                                                          true;
                                                                      _model.messagesCount =
                                                                          _model.messagesCount! +
                                                                              1;
                                                                      safeSetState(
                                                                          () {});
                                                                      logFirebaseEvent(
                                                                          'IconButtonSend_wait__delay');
                                                                      await Future
                                                                          .delayed(
                                                                        Duration(
                                                                          milliseconds:
                                                                              5000,
                                                                        ),
                                                                      );
                                                                    }),
                                                                    Future(
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'IconButtonSend_cloud_function');
                                                                      try {
                                                                        final result = await FirebaseFunctions
                                                                            .instance
                                                                            .httpsCallable('chatMessageStream')
                                                                            .call({
                                                                          "chatId":
                                                                              FFAppState().chatId,
                                                                          "message":
                                                                              _model.message!,
                                                                          "chatRefId": FFAppState()
                                                                              .chatRef!
                                                                              .id,
                                                                          "userId":
                                                                              currentUserUid,
                                                                        });
                                                                        _model.chatMessButton =
                                                                            ChatMessageStreamCloudFunctionCallResponse(
                                                                          succeeded:
                                                                              true,
                                                                        );
                                                                      } on FirebaseFunctionsException catch (error) {
                                                                        _model.chatMessButton =
                                                                            ChatMessageStreamCloudFunctionCallResponse(
                                                                          errorCode:
                                                                              error.code,
                                                                          succeeded:
                                                                              false,
                                                                        );
                                                                      }

                                                                      _shouldSetState =
                                                                          true;
                                                                    }),
                                                                  ]);
                                                                  logFirebaseEvent(
                                                                      'IconButtonSend_update_page_state');
                                                                  _model.message =
                                                                      null;
                                                                  _model.isTyping =
                                                                      false;
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  if (_shouldSetState)
                                                                    safeSetState(
                                                                        () {});
                                                                  return;
                                                                }

                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                              },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              if (responsiveVisibility(
                                context: context,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Container(
                                  height: 168.0,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 1.0,
                                          sigmaY: 3.0,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 48.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 68.0,
                                                height: 60.0,
                                                decoration: BoxDecoration(),
                                                child: Visibility(
                                                  visible:
                                                      _model.chatsUserCount > 0,
                                                  child: wrapWithModel(
                                                    model: _model
                                                        .chatListButtonModel,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: BackButtonWidget(
                                                      icon: Icon(
                                                        FFIcons.khistory24,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      action: () async {
                                                        logFirebaseEvent(
                                                            'CHAT_PAGE_PAGE_chatListButton_CALLBACK');
                                                        logFirebaseEvent(
                                                            'chatListButton_update_page_state');
                                                        _model.chatListShow =
                                                            !_model
                                                                .chatListShow;
                                                        _model.message = null;
                                                        _model.imageGenerate =
                                                            false;
                                                        _model.isTyping = false;
                                                        safeSetState(() {});
                                                        if (_model
                                                            .chatListShow) {
                                                          logFirebaseEvent(
                                                              'chatListButton_clear_text_fields_pin_cod');
                                                          safeSetState(() {
                                                            _model
                                                                .messageFieldNewChatTextController
                                                                ?.clear();
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (FFAppState().chatRef != null)
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/logo34.webp',
                                                        height: 90.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      'ДАРЛИ',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.4,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumIsCustom,
                                                          ),
                                                    ),
                                                  ],
                                                ).animateOnPageLoad(animationsMap[
                                                    'columnOnPageLoadAnimation2']!),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 12.0, 0.0),
                                                child: wrapWithModel(
                                                  model: _model.infoButtonModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: BackButtonWidget(
                                                    icon: Icon(
                                                      FFIcons.kinfo,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                    action: () async {
                                                      logFirebaseEvent(
                                                          'CHAT_PAGE_PAGE_infoButton_CALLBACK');
                                                      logFirebaseEvent(
                                                          'infoButton_bottom_sheet');
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (context) {
                                                          return WebViewAware(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child: Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    ChatDialogIconWidget(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (valueOrDefault<bool>(
                      _model.chatListShow,
                      false,
                    ) &&
                    responsiveVisibility(
                      context: context,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                  Container(
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/Background.webp',
                        ).image,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      children: [
                        StreamBuilder<List<ChatsRecord>>(
                          stream: queryChatsRecord(
                            queryBuilder: (chatsRecord) => chatsRecord
                                .where(
                                  'created_by',
                                  isEqualTo: currentUserUid,
                                )
                                .orderBy('created_at', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<ChatsRecord> containerChatsRecordList =
                                snapshot.data!;

                            return Container(
                              constraints: BoxConstraints(
                                maxWidth: 600.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Builder(
                                    builder: (context) {
                                      final dates = containerChatsRecordList
                                          .unique((e) => dateTimeFormat(
                                                "M/y",
                                                e.createdAt!,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ))
                                          .toList();

                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(dates.length,
                                                  (datesIndex) {
                                            final datesItem = dates[datesIndex];
                                            return Container(
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 16.0, 20.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          dateTimeFormat(
                                                                    "M/y",
                                                                    datesItem
                                                                        .createdAt,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ) ==
                                                                  dateTimeFormat(
                                                                    "M/y",
                                                                    getCurrentTimestamp,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  )
                                                              ? 'Последний месяц'
                                                              : ((String text) {
                                                                  return text
                                                                          .isEmpty
                                                                      ? ' '
                                                                      : text[0]
                                                                              .toUpperCase() +
                                                                          text.substring(
                                                                              1);
                                                                }(valueOrDefault<
                                                                  String>(
                                                                  dateTimeFormat(
                                                                    "LLLL yyyy",
                                                                    datesItem
                                                                        .createdAt,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                                  'Последний месяц',
                                                                ))),
                                                          'Последний месяц',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelSmall
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmallFamily,
                                                              fontSize: 15.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmallIsCustom,
                                                            ),
                                                      ),
                                                    ),
                                                    Builder(
                                                      builder: (context) {
                                                        final chats =
                                                            containerChatsRecordList
                                                                .where((e) =>
                                                                    dateTimeFormat(
                                                                      "M/y",
                                                                      e.createdAt,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    ) ==
                                                                    dateTimeFormat(
                                                                      "M/y",
                                                                      datesItem
                                                                          .createdAt,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    ))
                                                                .toList();

                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children:
                                                              List.generate(
                                                                  chats.length,
                                                                  (chatsIndex) {
                                                            final chatsItem =
                                                                chats[
                                                                    chatsIndex];
                                                            return Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  if (chatsIndex !=
                                                                      0)
                                                                    Divider(
                                                                      height:
                                                                          1.0,
                                                                      thickness:
                                                                          1.0,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .white12,
                                                                    ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            16.0,
                                                                            0.0,
                                                                            16.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Expanded(
                                                                          child:
                                                                              InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              logFirebaseEvent('CHAT_PAGE_PAGE_Text_k00ldwyl_ON_TAP');
                                                                              var _shouldSetState = false;
                                                                              if (chatsItem.chatId == null || chatsItem.chatId == '') {
                                                                                logFirebaseEvent('Text_backend_call');
                                                                                _model.chatExistApi = await ChatAssistantGroup.chatIdCall.call(
                                                                                  userId: currentUserUid,
                                                                                );

                                                                                _shouldSetState = true;
                                                                                if ((_model.chatExistApi?.succeeded ?? true)) {
                                                                                  logFirebaseEvent('Text_update_app_state');
                                                                                  FFAppState().chatId = (_model.chatExistApi?.bodyText ?? '');
                                                                                  safeSetState(() {});
                                                                                  logFirebaseEvent('Text_backend_call');
                                                                                  unawaited(
                                                                                    () async {
                                                                                      await chatsItem.reference.update(createChatsRecordData(
                                                                                        chatId: (_model.chatExistApi?.bodyText ?? ''),
                                                                                      ));
                                                                                    }(),
                                                                                  );
                                                                                } else {
                                                                                  logFirebaseEvent('Text_show_snack_bar');
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        (_model.chatExistApi?.bodyText ?? ''),
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                        ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 4000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                    ),
                                                                                  );
                                                                                  if (_shouldSetState) safeSetState(() {});
                                                                                  return;
                                                                                }
                                                                              } else {
                                                                                logFirebaseEvent('Text_update_app_state');
                                                                                FFAppState().chatId = chatsItem.chatId;
                                                                                safeSetState(() {});
                                                                              }

                                                                              logFirebaseEvent('Text_update_app_state');
                                                                              FFAppState().chatRef = chatsItem.reference;
                                                                              safeSetState(() {});
                                                                              logFirebaseEvent('Text_update_page_state');
                                                                              _model.chatListShow = false;
                                                                              safeSetState(() {});
                                                                              if (_shouldSetState)
                                                                                safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              (String text) {
                                                                                return text.isEmpty ? ' ' : text[0].toUpperCase() + text.substring(1);
                                                                              }(valueOrDefault<String>(
                                                                                chatsItem.title,
                                                                                'unnamed',
                                                                              )),
                                                                              maxLines: 1,
                                                                              style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: !FlutterFlowTheme.of(context).labelLargeIsCustom,
                                                                                  ),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Builder(
                                                                          builder: (context) =>
                                                                              InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              logFirebaseEvent('CHAT_PAGE_PAGE_Icon_tmp39136_ON_TAP');
                                                                              logFirebaseEvent('Icon_alert_dialog');
                                                                              await showDialog(
                                                                                context: context,
                                                                                builder: (dialogContext) {
                                                                                  return Dialog(
                                                                                    elevation: 0,
                                                                                    insetPadding: EdgeInsets.zero,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                    child: WebViewAware(
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          FocusScope.of(dialogContext).unfocus();
                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                        },
                                                                                        child: ChatDeleteDialogWidget(
                                                                                          chatRef: chatsItem.reference,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              FFIcons.kmore2,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 8.0)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                              .addToStart(
                                                  SizedBox(height: 150.0))
                                              .addToEnd(SizedBox(
                                                  height:
                                                      valueOrDefault<double>(
                                                (isWeb
                                                        ? MediaQuery.viewInsetsOf(
                                                                    context)
                                                                .bottom >
                                                            0
                                                        : _isKeyboardVisible)
                                                    ? 140.0
                                                    : valueOrDefault<double>(
                                                        valueOrDefault<bool>(
                                                          (_model.messagesCount! >=
                                                                  10) &&
                                                              !valueOrDefault<
                                                                  bool>(
                                                                functions.dateGreatherThanToday(
                                                                    currentUserDocument
                                                                        ?.subscriptionExpDate),
                                                                false,
                                                              ) &&
                                                              () {
                                                                if (isiOS) {
                                                                  return !valueOrDefault<
                                                                      bool>(
                                                                    functions.checkVersionReview(
                                                                        FFAppState()
                                                                            .version,
                                                                        getRemoteConfigString(
                                                                            'appleReviewVersion')),
                                                                    false,
                                                                  );
                                                                } else if (isAndroid) {
                                                                  return !valueOrDefault<
                                                                      bool>(
                                                                    functions.checkVersionReview(
                                                                        FFAppState()
                                                                            .version,
                                                                        getRemoteConfigString(
                                                                            'googleReviewVersion')),
                                                                    false,
                                                                  );
                                                                } else {
                                                                  return true;
                                                                }
                                                              }(),
                                                          false,
                                                        )
                                                            ? 240.0
                                                            : 192.0,
                                                        192.0,
                                                      ),
                                                192.0,
                                              ))),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Builder(
                            builder: (context) {
                              if (valueOrDefault<bool>(
                                (_model.messagesCount! >= 10) &&
                                    !valueOrDefault<bool>(
                                      functions.dateGreatherThanToday(
                                          currentUserDocument
                                              ?.subscriptionExpDate),
                                      false,
                                    ) &&
                                    () {
                                      if (isiOS) {
                                        return !valueOrDefault<bool>(
                                          functions.checkVersionReview(
                                              FFAppState().version,
                                              getRemoteConfigString(
                                                  'appleReviewVersion')),
                                          false,
                                        );
                                      } else if (isAndroid) {
                                        return !valueOrDefault<bool>(
                                          functions.checkVersionReview(
                                              FFAppState().version,
                                              getRemoteConfigString(
                                                  'googleReviewVersion')),
                                          false,
                                        );
                                      } else {
                                        return true;
                                      }
                                    }(),
                                false,
                              )) {
                                return Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 800.0,
                                  ),
                                  decoration: BoxDecoration(),
                                  child: wrapWithModel(
                                    model: _model.paymentChatButtonModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PaymentChatButtonWidget(),
                                  ),
                                );
                              } else {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 1.0,
                                      sigmaY: 3.0,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0,
                                          0.0,
                                          20.0,
                                          valueOrDefault<double>(
                                            () {
                                              if (MediaQuery.sizeOf(context)
                                                      .width <
                                                  kBreakpointSmall) {
                                                return valueOrDefault<double>(
                                                  (isWeb
                                                          ? MediaQuery.viewInsetsOf(
                                                                      context)
                                                                  .bottom >
                                                              0
                                                          : _isKeyboardVisible)
                                                      ? 12.0
                                                      : 120.0,
                                                  120.0,
                                                );
                                              } else if (MediaQuery.sizeOf(
                                                          context)
                                                      .width <
                                                  kBreakpointMedium) {
                                                return valueOrDefault<double>(
                                                  (isWeb
                                                          ? MediaQuery.viewInsetsOf(
                                                                      context)
                                                                  .bottom >
                                                              0
                                                          : _isKeyboardVisible)
                                                      ? 12.0
                                                      : 120.0,
                                                  120.0,
                                                );
                                              } else if (MediaQuery.sizeOf(
                                                          context)
                                                      .width <
                                                  kBreakpointLarge) {
                                                return 24.0;
                                              } else {
                                                return 24.0;
                                              }
                                            }(),
                                            24.0,
                                          )),
                                      child: Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          minHeight: 48.0,
                                          maxWidth: 800.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .white12,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 24.0,
                                              color: Color(0x1F2A2929),
                                              offset: Offset(
                                                0.0,
                                                4.0,
                                              ),
                                              spreadRadius: 0.0,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .white12,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: _model
                                                      .messageFieldNewChatTextController,
                                                  focusNode: _model
                                                      .messageFieldNewChatFocusNode,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.messageFieldNewChatTextController',
                                                    Duration(
                                                        milliseconds: 1000),
                                                    () => safeSetState(() {}),
                                                  ),
                                                  onFieldSubmitted: (_) async {
                                                    logFirebaseEvent(
                                                        'CHAT_messageFieldNewChat_ON_TEXTFIELD_SU');
                                                    var _shouldSetState = false;
                                                    if (_model.messageFieldNewChatTextController
                                                                .text !=
                                                            null &&
                                                        _model.messageFieldNewChatTextController
                                                                .text !=
                                                            '') {
                                                      logFirebaseEvent(
                                                          'messageFieldNewChat_update_app_state');
                                                      FFAppState().pressetChat =
                                                          '';
                                                      FFAppState().chatRef =
                                                          null;
                                                      safeSetState(() {});
                                                      logFirebaseEvent(
                                                          'messageFieldNewChat_update_page_state');
                                                      _model.message = _model
                                                          .messageFieldNewChatTextController
                                                          .text;
                                                      safeSetState(() {});
                                                      logFirebaseEvent(
                                                          'messageFieldNewChat_clear_text_fields_pi');
                                                      safeSetState(() {
                                                        _model
                                                            .messageFieldNewChatTextController
                                                            ?.clear();
                                                        _model
                                                            .messageFieldTextController
                                                            ?.clear();
                                                      });
                                                      logFirebaseEvent(
                                                          'messageFieldNewChat_custom_action');
                                                      unawaited(
                                                        () async {
                                                          await actions
                                                              .closeKeyboard(
                                                            context,
                                                          );
                                                        }(),
                                                      );
                                                      logFirebaseEvent(
                                                          'messageFieldNewChat_backend_call');
                                                      _model.chatIdFieldApi =
                                                          await ChatAssistantGroup
                                                              .chatIdCall
                                                              .call(
                                                        userId: currentUserUid,
                                                      );

                                                      _shouldSetState = true;
                                                      if ((_model.chatIdFieldApi
                                                              ?.succeeded ??
                                                          true)) {
                                                        logFirebaseEvent(
                                                            'messageFieldNewChat_backend_call');

                                                        var chatsRecordReference =
                                                            ChatsRecord
                                                                .collection
                                                                .doc();
                                                        await chatsRecordReference
                                                            .set(
                                                                createChatsRecordData(
                                                          createdBy:
                                                              currentUserUid,
                                                          createdAt:
                                                              getCurrentTimestamp,
                                                          title: (String text) {
                                                            return text.isEmpty
                                                                ? ' '
                                                                : text[0]
                                                                        .toUpperCase() +
                                                                    text.substring(
                                                                        1);
                                                          }(_model.message!),
                                                          chatId:
                                                              ChatAssistantGroup
                                                                  .chatIdCall
                                                                  .chatId(
                                                            (_model.chatIdFieldApi
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                        ));
                                                        _model.newChatField = ChatsRecord
                                                            .getDocumentFromData(
                                                                createChatsRecordData(
                                                                  createdBy:
                                                                      currentUserUid,
                                                                  createdAt:
                                                                      getCurrentTimestamp,
                                                                  title: (String
                                                                      text) {
                                                                    return text
                                                                            .isEmpty
                                                                        ? ' '
                                                                        : text[0].toUpperCase() +
                                                                            text.substring(1);
                                                                  }(_model
                                                                      .message!),
                                                                  chatId: ChatAssistantGroup
                                                                      .chatIdCall
                                                                      .chatId(
                                                                    (_model.chatIdFieldApi
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ),
                                                                ),
                                                                chatsRecordReference);
                                                        _shouldSetState = true;
                                                        logFirebaseEvent(
                                                            'messageFieldNewChat_update_app_state');
                                                        FFAppState().chatRef =
                                                            _model.newChatField
                                                                ?.reference;
                                                        FFAppState().chatId =
                                                            FFAppState().chatId;
                                                        safeSetState(() {});
                                                        logFirebaseEvent(
                                                            'messageFieldNewChat_update_page_state');
                                                        _model.chatListShow =
                                                            false;
                                                        _model.chatsUserCount =
                                                            _model.chatsUserCount +
                                                                1;
                                                        safeSetState(() {});
                                                        logFirebaseEvent(
                                                            'messageFieldNewChat_backend_call');

                                                        var chatMessagesRecordReference =
                                                            ChatMessagesRecord
                                                                .collection
                                                                .doc();
                                                        await chatMessagesRecordReference
                                                            .set(
                                                                createChatMessagesRecordData(
                                                          createdBy:
                                                              currentUserUid,
                                                          createdAt:
                                                              getCurrentTimestamp,
                                                          text: _model.message,
                                                          chatRef: FFAppState()
                                                              .chatRef,
                                                          role: 'user',
                                                        ));
                                                        _model.createMessageFieldNewChat =
                                                            ChatMessagesRecord
                                                                .getDocumentFromData(
                                                                    createChatMessagesRecordData(
                                                                      createdBy:
                                                                          currentUserUid,
                                                                      createdAt:
                                                                          getCurrentTimestamp,
                                                                      text: _model
                                                                          .message,
                                                                      chatRef:
                                                                          FFAppState()
                                                                              .chatRef,
                                                                      role:
                                                                          'user',
                                                                    ),
                                                                    chatMessagesRecordReference);
                                                        _shouldSetState = true;
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'messageFieldNewChat_update_page_state');
                                                            _model.isTyping =
                                                                true;
                                                            _model.messagesCount =
                                                                _model.messagesCount! +
                                                                    1;
                                                            safeSetState(() {});
                                                            logFirebaseEvent(
                                                                'messageFieldNewChat_wait__delay');
                                                            await Future
                                                                .delayed(
                                                              Duration(
                                                                milliseconds:
                                                                    5000,
                                                              ),
                                                            );
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'messageFieldNewChat_cloud_function');
                                                            try {
                                                              final result =
                                                                  await FirebaseFunctions
                                                                      .instance
                                                                      .httpsCallable(
                                                                          'chatMessageStream')
                                                                      .call({
                                                                "chatId":
                                                                    FFAppState()
                                                                        .chatId,
                                                                "message": _model
                                                                    .message!,
                                                                "chatRefId":
                                                                    FFAppState()
                                                                        .chatRef!
                                                                        .id,
                                                                "userId":
                                                                    currentUserUid,
                                                              });
                                                              _model.chatMessFieldNew =
                                                                  ChatMessageStreamCloudFunctionCallResponse(
                                                                succeeded: true,
                                                              );
                                                            } on FirebaseFunctionsException catch (error) {
                                                              _model.chatMessFieldNew =
                                                                  ChatMessageStreamCloudFunctionCallResponse(
                                                                errorCode:
                                                                    error.code,
                                                                succeeded:
                                                                    false,
                                                              );
                                                            }

                                                            _shouldSetState =
                                                                true;
                                                          }),
                                                        ]);
                                                        logFirebaseEvent(
                                                            'messageFieldNewChat_update_page_state');
                                                        _model.message = null;
                                                        _model.isTyping = false;
                                                        safeSetState(() {});
                                                      } else {
                                                        logFirebaseEvent(
                                                            'messageFieldNewChat_show_snack_bar');
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              (_model.chatIdFieldApi
                                                                      ?.bodyText ??
                                                                  ''),
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .white12,
                                                          ),
                                                        );
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }
                                                    } else {
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }

                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                  },
                                                  autofocus: false,
                                                  textInputAction:
                                                      TextInputAction.send,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumIsCustom,
                                                            ),
                                                    hintText:
                                                        'Начать новый чат',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.25,
                                                        ),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                0.0, 0.0),
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            lineHeight: 1.25,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                  maxLines: 10,
                                                  minLines: 1,
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  enableInteractiveSelection:
                                                      true,
                                                  validator: _model
                                                      .messageFieldNewChatTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 4.0, 4.0),
                                              child: FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 99.0,
                                                buttonSize: 40.0,
                                                fillColor:
                                                    valueOrDefault<Color>(
                                                  _model.messageFieldNewChatTextController
                                                                  .text ==
                                                              null ||
                                                          _model
                                                                  .messageFieldNewChatTextController
                                                                  .text ==
                                                              ''
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .white24
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  FlutterFlowTheme.of(context)
                                                      .white24,
                                                ),
                                                disabledColor:
                                                    FlutterFlowTheme.of(context)
                                                        .white24,
                                                icon: Icon(
                                                  FFIcons.karrowUp,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 24.0,
                                                ),
                                                onPressed:
                                                    (_model.messageFieldNewChatTextController
                                                                    .text ==
                                                                null ||
                                                            _model.messageFieldNewChatTextController
                                                                    .text ==
                                                                '')
                                                        ? null
                                                        : () async {
                                                            logFirebaseEvent(
                                                                'CHAT_PAGE_PAGE_IconButtonSendN_ON_TAP');
                                                            var _shouldSetState =
                                                                false;
                                                            if (_model.messageFieldNewChatTextController
                                                                        .text !=
                                                                    null &&
                                                                _model.messageFieldNewChatTextController
                                                                        .text !=
                                                                    '') {
                                                              logFirebaseEvent(
                                                                  'IconButtonSendN_update_app_state');
                                                              FFAppState()
                                                                  .pressetChat = '';
                                                              FFAppState()
                                                                      .chatRef =
                                                                  null;
                                                              safeSetState(
                                                                  () {});
                                                              logFirebaseEvent(
                                                                  'IconButtonSendN_update_page_state');
                                                              _model.message =
                                                                  _model
                                                                      .messageFieldNewChatTextController
                                                                      .text;
                                                              safeSetState(
                                                                  () {});
                                                              logFirebaseEvent(
                                                                  'IconButtonSendN_clear_text_fields_pin_co');
                                                              safeSetState(() {
                                                                _model
                                                                    .messageFieldNewChatTextController
                                                                    ?.clear();
                                                                _model
                                                                    .messageFieldTextController
                                                                    ?.clear();
                                                              });
                                                              logFirebaseEvent(
                                                                  'IconButtonSendN_custom_action');
                                                              unawaited(
                                                                () async {
                                                                  await actions
                                                                      .closeKeyboard(
                                                                    context,
                                                                  );
                                                                }(),
                                                              );
                                                              logFirebaseEvent(
                                                                  'IconButtonSendN_backend_call');
                                                              _model.chatIdButtonApi =
                                                                  await ChatAssistantGroup
                                                                      .chatIdCall
                                                                      .call(
                                                                userId:
                                                                    currentUserUid,
                                                              );

                                                              _shouldSetState =
                                                                  true;
                                                              if ((_model
                                                                      .chatIdButtonApi
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                logFirebaseEvent(
                                                                    'IconButtonSendN_backend_call');

                                                                var chatsRecordReference =
                                                                    ChatsRecord
                                                                        .collection
                                                                        .doc();
                                                                await chatsRecordReference
                                                                    .set(
                                                                        createChatsRecordData(
                                                                  createdBy:
                                                                      currentUserUid,
                                                                  createdAt:
                                                                      getCurrentTimestamp,
                                                                  title: (String
                                                                      text) {
                                                                    return text
                                                                            .isEmpty
                                                                        ? ' '
                                                                        : text[0].toUpperCase() +
                                                                            text.substring(1);
                                                                  }(_model
                                                                      .message!),
                                                                  chatId: ChatAssistantGroup
                                                                      .chatIdCall
                                                                      .chatId(
                                                                    (_model.chatIdButtonApi
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ),
                                                                ));
                                                                _model.newChatButton =
                                                                    ChatsRecord.getDocumentFromData(
                                                                        createChatsRecordData(
                                                                          createdBy:
                                                                              currentUserUid,
                                                                          createdAt:
                                                                              getCurrentTimestamp,
                                                                          title: (String
                                                                              text) {
                                                                            return text.isEmpty
                                                                                ? ' '
                                                                                : text[0].toUpperCase() + text.substring(1);
                                                                          }(_model
                                                                              .message!),
                                                                          chatId: ChatAssistantGroup
                                                                              .chatIdCall
                                                                              .chatId(
                                                                            (_model.chatIdButtonApi?.jsonBody ??
                                                                                ''),
                                                                          ),
                                                                        ),
                                                                        chatsRecordReference);
                                                                _shouldSetState =
                                                                    true;
                                                                logFirebaseEvent(
                                                                    'IconButtonSendN_update_app_state');
                                                                FFAppState()
                                                                        .chatRef =
                                                                    _model
                                                                        .newChatButton
                                                                        ?.reference;
                                                                FFAppState()
                                                                        .chatId =
                                                                    FFAppState()
                                                                        .chatId;
                                                                safeSetState(
                                                                    () {});
                                                                logFirebaseEvent(
                                                                    'IconButtonSendN_update_page_state');
                                                                _model.chatListShow =
                                                                    false;
                                                                _model.chatsUserCount =
                                                                    _model.chatsUserCount +
                                                                        1;
                                                                safeSetState(
                                                                    () {});
                                                                logFirebaseEvent(
                                                                    'IconButtonSendN_backend_call');

                                                                var chatMessagesRecordReference =
                                                                    ChatMessagesRecord
                                                                        .collection
                                                                        .doc();
                                                                await chatMessagesRecordReference
                                                                    .set(
                                                                        createChatMessagesRecordData(
                                                                  createdBy:
                                                                      currentUserUid,
                                                                  createdAt:
                                                                      getCurrentTimestamp,
                                                                  text: _model
                                                                      .message,
                                                                  chatRef:
                                                                      FFAppState()
                                                                          .chatRef,
                                                                  role: 'user',
                                                                ));
                                                                _model.createMessageButtonNewChat =
                                                                    ChatMessagesRecord
                                                                        .getDocumentFromData(
                                                                            createChatMessagesRecordData(
                                                                              createdBy: currentUserUid,
                                                                              createdAt: getCurrentTimestamp,
                                                                              text: _model.message,
                                                                              chatRef: FFAppState().chatRef,
                                                                              role: 'user',
                                                                            ),
                                                                            chatMessagesRecordReference);
                                                                _shouldSetState =
                                                                    true;
                                                                await Future
                                                                    .wait([
                                                                  Future(
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'IconButtonSendN_update_page_state');
                                                                    _model.isTyping =
                                                                        true;
                                                                    _model.messagesCount =
                                                                        _model.messagesCount! +
                                                                            1;
                                                                    safeSetState(
                                                                        () {});
                                                                    logFirebaseEvent(
                                                                        'IconButtonSendN_wait__delay');
                                                                    await Future
                                                                        .delayed(
                                                                      Duration(
                                                                        milliseconds:
                                                                            5000,
                                                                      ),
                                                                    );
                                                                  }),
                                                                  Future(
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'IconButtonSendN_cloud_function');
                                                                    try {
                                                                      final result = await FirebaseFunctions
                                                                          .instance
                                                                          .httpsCallable(
                                                                              'chatMessageStream')
                                                                          .call({
                                                                        "chatId":
                                                                            FFAppState().chatId,
                                                                        "message":
                                                                            _model.message!,
                                                                        "chatRefId": FFAppState()
                                                                            .chatRef!
                                                                            .id,
                                                                        "userId":
                                                                            currentUserUid,
                                                                      });
                                                                      _model.chatMessFileButtonNew =
                                                                          ChatMessageStreamCloudFunctionCallResponse(
                                                                        succeeded:
                                                                            true,
                                                                      );
                                                                    } on FirebaseFunctionsException catch (error) {
                                                                      _model.chatMessFileButtonNew =
                                                                          ChatMessageStreamCloudFunctionCallResponse(
                                                                        errorCode:
                                                                            error.code,
                                                                        succeeded:
                                                                            false,
                                                                      );
                                                                    }

                                                                    _shouldSetState =
                                                                        true;
                                                                  }),
                                                                ]);
                                                                logFirebaseEvent(
                                                                    'IconButtonSendN_update_page_state');
                                                                _model.message =
                                                                    null;
                                                                _model.isTyping =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'IconButtonSendN_show_snack_bar');
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      (_model.chatIdButtonApi
                                                                              ?.bodyText ??
                                                                          ''),
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .white12,
                                                                  ),
                                                                );
                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                                return;
                                                              }
                                                            } else {
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }

                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                          },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 1.0,
                                sigmaY: 3.0,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 74.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    wrapWithModel(
                                      model: _model.backButtonModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: BackButtonWidget(
                                        icon: Icon(
                                          FFIcons.kcloseIcon,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 28.0,
                                        ),
                                        action: () async {
                                          logFirebaseEvent(
                                              'CHAT_Container_vgh9qlm9_CALLBACK');
                                          logFirebaseEvent(
                                              'backButton_update_page_state');
                                          unawaited(
                                            () async {
                                              _model.chatListShow = false;
                                              _model.isTyping = false;
                                              safeSetState(() {});
                                            }(),
                                          );
                                        },
                                      ),
                                    ),
                                    Text(
                                      'История чатов',
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleMediumFamily,
                                            fontSize: 17.0,
                                            letterSpacing: 0.0,
                                            lineHeight: 1.2,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleMediumIsCustom,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 12.0, 0.0),
                                      child: Container(
                                        width: 56.0,
                                        height: 0.0,
                                        decoration: BoxDecoration(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!valueOrDefault<bool>(
                  isWeb
                      ? MediaQuery.viewInsetsOf(context).bottom > 0
                      : _isKeyboardVisible,
                  false,
                ))
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: wrapWithModel(
                      model: _model.navbarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: NavbarWidget(
                        pageNum: 3.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
