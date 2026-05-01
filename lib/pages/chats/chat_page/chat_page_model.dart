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
import 'chat_page_widget.dart' show ChatPageWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ChatPageModel extends FlutterFlowModel<ChatPageWidget> {
  ///  Local state fields for this page.

  int? messagesCount = 0;

  bool isTyping = false;

  bool imageGenerate = false;

  String? message;

  bool chatListShow = false;

  int chatsUserCount = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in ChatPage widget.
  int? messageCountQuery;
  // Stores action output result for [Firestore Query - Query a collection] action in ChatPage widget.
  int? chatsUser;
  // Stores action output result for [Firestore Query - Query a collection] action in ChatPage widget.
  int? chatsCount;
  // Model for navbarWeb component.
  late NavbarWebModel navbarWebModel;
  List<ChatMessagesRecord>? containerPreviousSnapshot;
  // Model for emptyMessages component.
  late EmptyMessagesModel emptyMessagesModel;
  // Model for paymentChatButton component.
  late PaymentChatButtonModel paymentChatButtonModel1;
  // State field(s) for messageField widget.
  FocusNode? messageFieldFocusNode;
  TextEditingController? messageFieldTextController;
  String? Function(BuildContext, String?)? messageFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (chatId)] action in messageField widget.
  ApiCallResponse? newChatAPI;
  // Stores action output result for [Backend Call - Create Document] action in messageField widget.
  ChatsRecord? newChatField1;
  // Stores action output result for [Backend Call - Create Document] action in messageField widget.
  ChatMessagesRecord? createMessageField;
  // Stores action output result for [Cloud Function - chatMessageStream] action in messageField widget.
  ChatMessageStreamCloudFunctionCallResponse? chatMessField;
  // Stores action output result for [Backend Call - API (chatId)] action in IconButtonSend widget.
  ApiCallResponse? newChatAPIbutton;
  // Stores action output result for [Backend Call - Create Document] action in IconButtonSend widget.
  ChatsRecord? newChatButton1;
  // Stores action output result for [Backend Call - Create Document] action in IconButtonSend widget.
  ChatMessagesRecord? createMessageButton;
  // Stores action output result for [Cloud Function - chatMessageStream] action in IconButtonSend widget.
  ChatMessageStreamCloudFunctionCallResponse? chatMessButton;
  // Model for chatListButton.
  late BackButtonModel chatListButtonModel;
  // Model for infoButton.
  late BackButtonModel infoButtonModel;
  // Stores action output result for [Backend Call - API (chatId)] action in Text widget.
  ApiCallResponse? chatExistApi;
  // Model for paymentChatButton component.
  late PaymentChatButtonModel paymentChatButtonModel2;
  // State field(s) for messageFieldNewChat widget.
  FocusNode? messageFieldNewChatFocusNode;
  TextEditingController? messageFieldNewChatTextController;
  String? Function(BuildContext, String?)?
      messageFieldNewChatTextControllerValidator;
  // Stores action output result for [Backend Call - API (chatId)] action in messageFieldNewChat widget.
  ApiCallResponse? chatIdFieldApi;
  // Stores action output result for [Backend Call - Create Document] action in messageFieldNewChat widget.
  ChatsRecord? newChatField;
  // Stores action output result for [Backend Call - Create Document] action in messageFieldNewChat widget.
  ChatMessagesRecord? createMessageFieldNewChat;
  // Stores action output result for [Cloud Function - chatMessageStream] action in messageFieldNewChat widget.
  ChatMessageStreamCloudFunctionCallResponse? chatMessFieldNew;
  // Stores action output result for [Backend Call - API (chatId)] action in IconButtonSendN widget.
  ApiCallResponse? chatIdButtonApi;
  // Stores action output result for [Backend Call - Create Document] action in IconButtonSendN widget.
  ChatsRecord? newChatButton;
  // Stores action output result for [Backend Call - Create Document] action in IconButtonSendN widget.
  ChatMessagesRecord? createMessageButtonNewChat;
  // Stores action output result for [Cloud Function - chatMessageStream] action in IconButtonSendN widget.
  ChatMessageStreamCloudFunctionCallResponse? chatMessFileButtonNew;
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarWebModel = createModel(context, () => NavbarWebModel());
    emptyMessagesModel = createModel(context, () => EmptyMessagesModel());
    paymentChatButtonModel1 =
        createModel(context, () => PaymentChatButtonModel());
    chatListButtonModel = createModel(context, () => BackButtonModel());
    infoButtonModel = createModel(context, () => BackButtonModel());
    paymentChatButtonModel2 =
        createModel(context, () => PaymentChatButtonModel());
    backButtonModel = createModel(context, () => BackButtonModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    navbarWebModel.dispose();
    emptyMessagesModel.dispose();
    paymentChatButtonModel1.dispose();
    messageFieldFocusNode?.dispose();
    messageFieldTextController?.dispose();

    chatListButtonModel.dispose();
    infoButtonModel.dispose();
    paymentChatButtonModel2.dispose();
    messageFieldNewChatFocusNode?.dispose();
    messageFieldNewChatTextController?.dispose();

    backButtonModel.dispose();
    navbarModel.dispose();
  }
}
