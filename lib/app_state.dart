import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _version = prefs.getString('ff_version') ?? _version;
    });
    _safeInit(() {
      _categories = prefs.getStringList('ff_categories') ?? _categories;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _version = '1.0.0 (1)';
  String get version => _version;
  set version(String value) {
    _version = value;
    prefs.setString('ff_version', value);
  }

  List<String> _categories = [
    'Новое',
    'Подкасты',
    'Аффирмации',
    'Медитации',
    'Избранное',
    'Практики'
  ];
  List<String> get categories => _categories;
  set categories(List<String> value) {
    _categories = value;
    prefs.setStringList('ff_categories', value);
  }

  void addToCategories(String value) {
    categories.add(value);
    prefs.setStringList('ff_categories', _categories);
  }

  void removeFromCategories(String value) {
    categories.remove(value);
    prefs.setStringList('ff_categories', _categories);
  }

  void removeAtIndexFromCategories(int index) {
    categories.removeAt(index);
    prefs.setStringList('ff_categories', _categories);
  }

  void updateCategoriesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    categories[index] = updateFn(_categories[index]);
    prefs.setStringList('ff_categories', _categories);
  }

  void insertAtIndexInCategories(int index, String value) {
    categories.insert(index, value);
    prefs.setStringList('ff_categories', _categories);
  }

  String _pressetChat = '';
  String get pressetChat => _pressetChat;
  set pressetChat(String value) {
    _pressetChat = value;
  }

  DocumentReference? _chatRef;
  DocumentReference? get chatRef => _chatRef;
  set chatRef(DocumentReference? value) {
    _chatRef = value;
  }

  DateTime? _refreshDate;
  DateTime? get refreshDate => _refreshDate;
  set refreshDate(DateTime? value) {
    _refreshDate = value;
  }

  String _chatId = '';
  String get chatId => _chatId;
  set chatId(String value) {
    _chatId = value;
  }

  final _newsManager = FutureRequestManager<List<NewsRecord>>();
  Future<List<NewsRecord>> news({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<NewsRecord>> Function() requestFn,
  }) =>
      _newsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearNewsCache() => _newsManager.clear();
  void clearNewsCacheKey(String? uniqueKey) =>
      _newsManager.clearRequest(uniqueKey);

  final _videosManager = FutureRequestManager<List<VideosRecord>>();
  Future<List<VideosRecord>> videos({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<VideosRecord>> Function() requestFn,
  }) =>
      _videosManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearVideosCache() => _videosManager.clear();
  void clearVideosCacheKey(String? uniqueKey) =>
      _videosManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
