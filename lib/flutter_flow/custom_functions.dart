import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<dynamic> countries() {
  return [
    {"flag": "🇦🇺", "name": "Австралия", "dial_code": "+61", "code": "AU"},
    {"flag": "🇦🇹", "name": "Австрия", "dial_code": "+43", "code": "AT"},
    {"flag": "🇦🇿", "name": "Азербайджан", "dial_code": "+994", "code": "AZ"},
    {"flag": "🇦🇱", "name": "Албания", "dial_code": "+355", "code": "AL"},
    {"flag": "🇩🇿", "name": "Алжир", "dial_code": "+213", "code": "DZ"},
    {"flag": "🇦🇴", "name": "Ангола", "dial_code": "+244", "code": "AO"},
    {"flag": "🇦🇩", "name": "Андорра", "dial_code": "+376", "code": "AD"},
    {
      "flag": "🇦🇬",
      "name": "Антигуа и Барбуда",
      "dial_code": "+1268",
      "code": "AG"
    },
    {"flag": "🇦🇷", "name": "Аргентина", "dial_code": "+54", "code": "AR"},
    {"flag": "🇦🇲", "name": "Армения", "dial_code": "+374", "code": "AM"},
    {"flag": "🇦🇫", "name": "Афганистан", "dial_code": "+93", "code": "AF"},
    {
      "flag": "🇧🇸",
      "name": "Багамские Острова",
      "dial_code": "+1242",
      "code": "BS"
    },
    {"flag": "🇧🇩", "name": "Бангладеш", "dial_code": "+880", "code": "BD"},
    {"flag": "🇧🇧", "name": "Барбадос", "dial_code": "+1246", "code": "BB"},
    {"flag": "🇧🇭", "name": "Бахрейн", "dial_code": "+973", "code": "BH"},
    {"flag": "🇧🇾", "name": "Беларусь", "dial_code": "+375", "code": "BY"},
    {"flag": "🇧🇿", "name": "Белиз", "dial_code": "+501", "code": "BZ"},
    {"flag": "🇧🇪", "name": "Бельгия", "dial_code": "+32", "code": "BE"},
    {"flag": "🇧🇯", "name": "Бенин", "dial_code": "+229", "code": "BJ"},
    {"flag": "🇧🇬", "name": "Болгария", "dial_code": "+359", "code": "BG"},
    {"flag": "🇧🇴", "name": "Боливия", "dial_code": "+591", "code": "BO"},
    {
      "flag": "🇧🇦",
      "name": "Босния и Герцеговина",
      "dial_code": "+387",
      "code": "BA"
    },
    {"flag": "🇧🇼", "name": "Ботсвана", "dial_code": "+267", "code": "BW"},
    {"flag": "🇧🇷", "name": "Бразилия", "dial_code": "+55", "code": "BR"},
    {"flag": "🇧🇳", "name": "Бруней", "dial_code": "+673", "code": "BN"},
    {"flag": "🇧🇫", "name": "Буркина-Фасо", "dial_code": "+226", "code": "BF"},
    {"flag": "🇧🇮", "name": "Бурунди", "dial_code": "+257", "code": "BI"},
    {"flag": "🇧🇹", "name": "Бутан", "dial_code": "+975", "code": "BT"},
    {"flag": "🇻🇺", "name": "Вануату", "dial_code": "+678", "code": "VU"},
    {"flag": "🇻🇦", "name": "Ватикан", "dial_code": "+379", "code": "VA"},
    {
      "flag": "🇬🇧",
      "name": "Великобритания",
      "dial_code": "+44",
      "code": "GB"
    },
    {"flag": "🇭🇺", "name": "Венгрия", "dial_code": "+36", "code": "HU"},
    {"flag": "🇻🇪", "name": "Венесуэла", "dial_code": "+58", "code": "VE"},
    {"flag": "🇻🇳", "name": "Вьетнам", "dial_code": "+84", "code": "VN"},
    {"flag": "🇬🇦", "name": "Габон", "dial_code": "+241", "code": "GA"},
    {"flag": "🇭🇹", "name": "Гаити", "dial_code": "+509", "code": "HT"},
    {"flag": "🇬🇾", "name": "Гайана", "dial_code": "+592", "code": "GY"},
    {"flag": "🇬🇲", "name": "Гамбия", "dial_code": "+220", "code": "GM"},
    {"flag": "🇬🇭", "name": "Гана", "dial_code": "+233", "code": "GH"},
    {"flag": "🇬🇹", "name": "Гватемала", "dial_code": "+502", "code": "GT"},
    {"flag": "🇬🇳", "name": "Гвинея", "dial_code": "+224", "code": "GN"},
    {"flag": "🇬🇼", "name": "Гвинея-Бисау", "dial_code": "+245", "code": "GW"},
    {"flag": "🇩🇪", "name": "Германия", "dial_code": "+49", "code": "DE"},
    {"flag": "🇭🇳", "name": "Гондурас", "dial_code": "+504", "code": "HN"},
    {"flag": "🇭🇰", "name": "Гонконг", "dial_code": "+852", "code": "HK"},
    {"flag": "🇬🇩", "name": "Гренада", "dial_code": "+1473", "code": "GD"},
    {"flag": "🇬🇷", "name": "Греция", "dial_code": "+30", "code": "GR"},
    {"flag": "🇬🇪", "name": "Грузия", "dial_code": "+995", "code": "GE"},
    {"flag": "🇩🇰", "name": "Дания", "dial_code": "+45", "code": "DK"},
    {
      "flag": "🇨🇩",
      "name": "Демократическая Республика Конго",
      "dial_code": "+243",
      "code": "CD"
    },
    {"flag": "🇩🇯", "name": "Джибути", "dial_code": "+253", "code": "DJ"},
    {"flag": "🇩🇲", "name": "Доминика", "dial_code": "+1767", "code": "DM"},
    {
      "flag": "🇩🇴",
      "name": "Доминиканская Республика",
      "dial_code": "+1849",
      "code": "DO"
    },
    {"flag": "🇪🇬", "name": "Египет", "dial_code": "+20", "code": "EG"},
    {"flag": "🇿🇲", "name": "Замбия", "dial_code": "+260", "code": "ZM"},
    {"flag": "🇿🇼", "name": "Зимбабве", "dial_code": "+263", "code": "ZW"},
    {"flag": "🇮🇱", "name": "Израиль", "dial_code": "+972", "code": "IL"},
    {"flag": "🇮🇳", "name": "Индия", "dial_code": "+91", "code": "IN"},
    {"flag": "🇮🇩", "name": "Индонезия", "dial_code": "+62", "code": "ID"},
    {"flag": "🇯🇴", "name": "Иордания", "dial_code": "+962", "code": "JO"},
    {"flag": "🇮🇶", "name": "Ирак", "dial_code": "+964", "code": "IQ"},
    {"flag": "🇮🇷", "name": "Иран", "dial_code": "+98", "code": "IR"},
    {"flag": "🇮🇪", "name": "Ирландия", "dial_code": "+353", "code": "IE"},
    {"flag": "🇮🇸", "name": "Исландия", "dial_code": "+354", "code": "IS"},
    {"flag": "🇪🇸", "name": "Испания", "dial_code": "+34", "code": "ES"},
    {"flag": "🇮🇹", "name": "Италия", "dial_code": "+39", "code": "IT"},
    {"flag": "🇾🇪", "name": "Йемен", "dial_code": "+967", "code": "YE"},
    {"flag": "🇨🇻", "name": "Кабо-Верде", "dial_code": "+238", "code": "CV"},
    {"flag": "🇰🇿", "name": "Казахстан", "dial_code": "+7", "code": "KZ"},
    {"flag": "🇰🇭", "name": "Камбоджа", "dial_code": "+855", "code": "KH"},
    {"flag": "🇨🇲", "name": "Камерун", "dial_code": "+237", "code": "CM"},
    {"flag": "🇨🇦", "name": "Канада", "dial_code": "+1", "code": "CA"},
    {"flag": "🇶🇦", "name": "Катар", "dial_code": "+974", "code": "QA"},
    {"flag": "🇰🇪", "name": "Кения", "dial_code": "+254", "code": "KE"},
    {"flag": "🇨🇾", "name": "Кипр", "dial_code": "+357", "code": "CY"},
    {"flag": "🇰🇬", "name": "Киргизия", "dial_code": "+996", "code": "KG"},
    {"flag": "🇰🇮", "name": "Кирибати", "dial_code": "+686", "code": "KI"},
    {"flag": "🇨🇳", "name": "Китай", "dial_code": "+86", "code": "CN"},
    {"flag": "🇨🇴", "name": "Колумбия", "dial_code": "+57", "code": "CO"},
    {"flag": "🇰🇲", "name": "Коморы", "dial_code": "+269", "code": "KM"},
    {"flag": "🇨🇬", "name": "Конго", "dial_code": "+242", "code": "CG"},
    {"flag": "🇰🇵", "name": "КНДР", "dial_code": "+850", "code": "KP"},
    {
      "flag": "🇰🇷",
      "name": "Республика Корея",
      "dial_code": "+82",
      "code": "KR"
    },
    {"flag": "🇨🇷", "name": "Коста-Рика", "dial_code": "+506", "code": "CR"},
    {"flag": "🇨🇮", "name": "Кот-д'Ивуар", "dial_code": "+225", "code": "CI"},
    {"flag": "🇨🇺", "name": "Куба", "dial_code": "+53", "code": "CU"},
    {"flag": "🇰🇼", "name": "Кувейт", "dial_code": "+965", "code": "KW"},
    {"flag": "🇱🇦", "name": "Лаос", "dial_code": "+856", "code": "LA"},
    {"flag": "🇱🇻", "name": "Латвия", "dial_code": "+371", "code": "LV"},
    {"flag": "🇱🇸", "name": "Лесото", "dial_code": "+266", "code": "LS"},
    {"flag": "🇱🇷", "name": "Либерия", "dial_code": "+231", "code": "LR"},
    {"flag": "🇱🇧", "name": "Ливан", "dial_code": "+961", "code": "LB"},
    {"flag": "🇱🇾", "name": "Ливия", "dial_code": "+218", "code": "LY"},
    {"flag": "🇱🇹", "name": "Литва", "dial_code": "+370", "code": "LT"},
    {"flag": "🇱🇮", "name": "Лихтенштейн", "dial_code": "+423", "code": "LI"},
    {"flag": "🇱🇺", "name": "Люксембург", "dial_code": "+352", "code": "LU"},
    {"flag": "🇲🇺", "name": "Маврикий", "dial_code": "+230", "code": "MU"},
    {"flag": "🇲🇷", "name": "Мавритания", "dial_code": "+222", "code": "MR"},
    {"flag": "🇲🇬", "name": "Мадагаскар", "dial_code": "+261", "code": "MG"},
    {"flag": "🇲🇼", "name": "Малави", "dial_code": "+265", "code": "MW"},
    {"flag": "🇲🇾", "name": "Малайзия", "dial_code": "+60", "code": "MY"},
    {"flag": "🇲🇱", "name": "Мали", "dial_code": "+223", "code": "ML"},
    {"flag": "🇲🇻", "name": "Мальдивы", "dial_code": "+960", "code": "MV"},
    {"flag": "🇲🇹", "name": "Мальта", "dial_code": "+356", "code": "MT"},
    {"flag": "🇲🇦", "name": "Марокко", "dial_code": "+212", "code": "MA"},
    {
      "flag": "🇲🇭",
      "name": "Маршалловы Острова",
      "dial_code": "+692",
      "code": "MH"
    },
    {"flag": "🇲🇽", "name": "Мексика", "dial_code": "+52", "code": "MX"},
    {"flag": "🇫🇲", "name": "Микронезия", "dial_code": "+691", "code": "FM"},
    {"flag": "🇲🇿", "name": "Мозамбик", "dial_code": "+258", "code": "MZ"},
    {"flag": "🇲🇩", "name": "Молдова", "dial_code": "+373", "code": "MD"},
    {"flag": "🇲🇨", "name": "Монако", "dial_code": "+377", "code": "MC"},
    {"flag": "🇲🇳", "name": "Монголия", "dial_code": "+976", "code": "MN"},
    {"flag": "🇲🇲", "name": "Мьянма", "dial_code": "+95", "code": "MM"},
    {"flag": "🇳🇦", "name": "Намибия", "dial_code": "+264", "code": "NA"},
    {"flag": "🇳🇷", "name": "Науру", "dial_code": "+674", "code": "NR"},
    {"flag": "🇳🇵", "name": "Непал", "dial_code": "+977", "code": "NP"},
    {"flag": "🇳🇪", "name": "Нигер", "dial_code": "+227", "code": "NE"},
    {"flag": "🇳🇬", "name": "Нигерия", "dial_code": "+234", "code": "NG"},
    {"flag": "🇳🇱", "name": "Нидерланды", "dial_code": "+31", "code": "NL"},
    {"flag": "🇳🇮", "name": "Никарагуа", "dial_code": "+505", "code": "NI"},
    {
      "flag": "🇳🇿",
      "name": "Новая Зеландия",
      "dial_code": "+64",
      "code": "NZ"
    },
    {"flag": "🇳🇴", "name": "Норвегия", "dial_code": "+47", "code": "NO"},
    {
      "flag": "🇦🇪",
      "name": "Объединенные Арабские Эмираты",
      "dial_code": "+971",
      "code": "AE"
    },
    {"flag": "🇴🇲", "name": "Оман", "dial_code": "+968", "code": "OM"},
    {"flag": "🇵🇰", "name": "Пакистан", "dial_code": "+92", "code": "PK"},
    {"flag": "🇵🇼", "name": "Палау", "dial_code": "+680", "code": "PW"},
    {"flag": "🇵🇦", "name": "Панама", "dial_code": "+507", "code": "PA"},
    {
      "flag": "🇵🇬",
      "name": "Папуа - Новая Гвинея",
      "dial_code": "+675",
      "code": "PG"
    },
    {"flag": "🇵🇾", "name": "Парагвай", "dial_code": "+595", "code": "PY"},
    {"flag": "🇵🇪", "name": "Перу", "dial_code": "+51", "code": "PE"},
    {"flag": "🇵🇱", "name": "Польша", "dial_code": "+48", "code": "PL"},
    {"flag": "🇵🇹", "name": "Португалия", "dial_code": "+351", "code": "PT"},
    {"flag": "🇷🇺", "name": "Россия", "dial_code": "+7", "code": "RU"},
    {"flag": "🇷🇼", "name": "Руанда", "dial_code": "+250", "code": "RW"},
    {"flag": "🇷🇴", "name": "Румыния", "dial_code": "+40", "code": "RO"},
    {"flag": "🇸🇻", "name": "Сальвадор", "dial_code": "+503", "code": "SV"},
    {"flag": "🇼🇸", "name": "Самоа", "dial_code": "+685", "code": "WS"},
    {"flag": "🇸🇲", "name": "Сан-Марино", "dial_code": "+378", "code": "SM"},
    {
      "flag": "🇸🇹",
      "name": "Сан-Томе и Принсипи",
      "dial_code": "+239",
      "code": "ST"
    },
    {
      "flag": "🇸🇦",
      "name": "Саудовская Аравия",
      "dial_code": "+966",
      "code": "SA"
    },
    {
      "flag": "🇲🇰",
      "name": "Северная Македония",
      "dial_code": "+389",
      "code": "MK"
    },
    {
      "flag": "🇸🇨",
      "name": "Сейшельские Острова",
      "dial_code": "+248",
      "code": "SC"
    },
    {"flag": "🇸🇳", "name": "Сенегал", "dial_code": "+221", "code": "SN"},
    {
      "flag": "🇻🇨",
      "name": "Сент-Винсент и Гренадины",
      "dial_code": "+1784",
      "code": "VC"
    },
    {
      "flag": "🇰🇳",
      "name": "Сент-Китс и Невис",
      "dial_code": "+1869",
      "code": "KN"
    },
    {"flag": "🇱🇨", "name": "Сент-Люсия", "dial_code": "+1758", "code": "LC"},
    {"flag": "🇷🇸", "name": "Сербия", "dial_code": "+381", "code": "RS"},
    {"flag": "🇸🇬", "name": "Сингапур", "dial_code": "+65", "code": "SG"},
    {"flag": "🇸🇾", "name": "Сирия", "dial_code": "+963", "code": "SY"},
    {"flag": "🇸🇰", "name": "Словакия", "dial_code": "+421", "code": "SK"},
    {"flag": "🇸🇮", "name": "Словения", "dial_code": "+386", "code": "SI"},
    {
      "flag": "🇺🇸",
      "name": "Соединенные Штаты Америки",
      "dial_code": "+1",
      "code": "US"
    },
    {
      "flag": "🇸🇧",
      "name": "Соломоновы Острова",
      "dial_code": "+677",
      "code": "SB"
    },
    {"flag": "🇸🇴", "name": "Сомали", "dial_code": "+252", "code": "SO"},
    {"flag": "🇸🇩", "name": "Судан", "dial_code": "+249", "code": "SD"},
    {"flag": "🇸🇷", "name": "Суринам", "dial_code": "+597", "code": "SR"},
    {"flag": "🇸🇱", "name": "Сьерра-Леоне", "dial_code": "+232", "code": "SL"},
    {"flag": "🇹🇯", "name": "Таджикистан", "dial_code": "+992", "code": "TJ"},
    {"flag": "🇹🇭", "name": "Таиланд", "dial_code": "+66", "code": "TH"},
    {"flag": "🇹🇼", "name": "Тайвань", "dial_code": "+886", "code": "TW"},
    {"flag": "🇹🇿", "name": "Танзания", "dial_code": "+255", "code": "TZ"},
    {"flag": "🇹🇬", "name": "Того", "dial_code": "+228", "code": "TG"},
    {"flag": "🇹🇴", "name": "Тонга", "dial_code": "+676", "code": "TO"},
    {
      "flag": "🇹🇹",
      "name": "Тринидад и Тобаго",
      "dial_code": "+1868",
      "code": "TT"
    },
    {"flag": "🇹🇻", "name": "Тувалу", "dial_code": "+688", "code": "TV"},
    {"flag": "🇹🇳", "name": "Тунис", "dial_code": "+216", "code": "TN"},
    {"flag": "🇹🇲", "name": "Туркменистан", "dial_code": "+993", "code": "TM"},
    {"flag": "🇹🇷", "name": "Турция", "dial_code": "+90", "code": "TR"},
    {"flag": "🇺🇬", "name": "Уганда", "dial_code": "+256", "code": "UG"},
    {"flag": "🇺🇿", "name": "Узбекистан", "dial_code": "+998", "code": "UZ"},
    {"flag": "🇺🇦", "name": "Украина", "dial_code": "+380", "code": "UA"},
    {"flag": "🇺🇾", "name": "Уругвай", "dial_code": "+598", "code": "UY"},
    {"flag": "🇫🇯", "name": "Фиджи", "dial_code": "+679", "code": "FJ"},
    {"flag": "🇵🇭", "name": "Филиппины", "dial_code": "+63", "code": "PH"},
    {"flag": "🇫🇮", "name": "Финляндия", "dial_code": "+358", "code": "FI"},
    {"flag": "🇫🇷", "name": "Франция", "dial_code": "+33", "code": "FR"},
    {"flag": "🇭🇷", "name": "Хорватия", "dial_code": "+385", "code": "HR"},
    {
      "flag": "🇨🇫",
      "name": "Центральноафриканская Республика",
      "dial_code": "+236",
      "code": "CF"
    },
    {"flag": "🇹🇩", "name": "Чад", "dial_code": "+235", "code": "TD"},
    {"flag": "🇲🇪", "name": "Черногория", "dial_code": "+382", "code": "ME"},
    {"flag": "🇨🇿", "name": "Чехия", "dial_code": "+420", "code": "CZ"},
    {"flag": "🇨🇱", "name": "Чили", "dial_code": "+56", "code": "CL"},
    {"flag": "🇨🇭", "name": "Швейцария", "dial_code": "+41", "code": "CH"},
    {"flag": "🇸🇪", "name": "Швеция", "dial_code": "+46", "code": "SE"},
    {"flag": "🇱🇰", "name": "Шри-Ланка", "dial_code": "+94", "code": "LK"},
    {"flag": "🇪🇨", "name": "Эквадор", "dial_code": "+593", "code": "EC"},
    {
      "flag": "🇬🇶",
      "name": "Экваториальная Гвинея",
      "dial_code": "+240",
      "code": "GQ"
    },
    {"flag": "🇪🇷", "name": "Эритрея", "dial_code": "+291", "code": "ER"},
    {"flag": "🇸🇿", "name": "Эсватини", "dial_code": "+268", "code": "SZ"},
    {"flag": "🇪🇪", "name": "Эстония", "dial_code": "+372", "code": "EE"},
    {"flag": "🇪🇹", "name": "Эфиопия", "dial_code": "+251", "code": "ET"},
    {"flag": "🇿🇦", "name": "ЮАР", "dial_code": "+27", "code": "ZA"},
    {"flag": "🇸🇸", "name": "Южный Судан", "dial_code": "+211", "code": "SS"},
    {"flag": "🇯🇲", "name": "Ямайка", "dial_code": "+1876", "code": "JM"},
    {"flag": "🇯🇵", "name": "Япония", "dial_code": "+81", "code": "JP"},
  ];
}

bool search(
  String? text,
  String? searchText,
  String? searchText2,
) {
  // If text is null or empty, return false
  if (text == null || text.trim().isEmpty) {
    return false;
  }

  // If both search fields are empty, return true (show all)
  if ((searchText == null || searchText.trim().isEmpty) &&
      (searchText2 == null || searchText2.trim().isEmpty)) {
    return true;
  }

  String normalizedText = text.toLowerCase().trim();
  String normalizedSearch = searchText?.toLowerCase().trim() ?? '';
  String normalizedSearch2 = searchText2?.toLowerCase().trim() ?? '';

  // Check if text contains either search field (OR logic)
  return normalizedText.contains(normalizedSearch) ||
      normalizedText.contains(normalizedSearch2);
}

DateTime dateMinusYears(
  DateTime date,
  int years,
) {
  // date minus years default date current date
  return DateTime(date.year - years, date.month, date.day);
}

List<int> daysList(int maxLength) {
  // Create a list from 1 to maxLength
  return List<int>.generate(maxLength, (index) => index + 1);
}

String dayText(int count) {
// Get the last digit and last two digits
  int lastDigit = count % 10;
  int lastTwoDigits = count % 100;

  // Rules for Russian declension of "день"
  // 1 день (one day)
  // 2, 3, 4 дня (two, three, four days)
  // 5, 6, 7, 8, 9, 0 дней (five+ days)
  // Exception: 11-14 always use дней

  if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
    return 'дней';
  }

  if (lastDigit == 1) {
    return 'день';
  }

  if (lastDigit >= 2 && lastDigit <= 4) {
    return 'дня';
  }

  return 'дней';
}

List<MonthCycleStruct> addCurrentMonthCycle(
  DateTime firstDay,
  int cycleDuration,
  int mensDuration,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  int effectiveCycleDuration(int value) {
    return value > 0 ? value : 28;
  }

  int effectiveMensDuration(int value) {
    return value > 0 ? value : 5;
  }

  List<DateTime> removeCollisions(
    List<DateTime> menstruationDays,
    List<DateTime> ovulationDays,
  ) {
    final ovulSet = ovulationDays.map(normalizeDate).toSet();
    return menstruationDays
        .map(normalizeDate)
        .where((d) => !ovulSet.contains(d))
        .toList()
      ..sort();
  }

  final normalizedFirstDay = normalizeDate(firstDay);
  final effectiveCycle = effectiveCycleDuration(cycleDuration);
  final effectiveMens = effectiveMensDuration(mensDuration);

  final now = DateTime.now();
  final startMonth = DateTime(
    normalizedFirstDay.year,
    normalizedFirstDay.month,
    1,
  );
  final endMonth = DateTime(now.year, 12, 1);

  MonthCycleStruct generateMonthCycle(DateTime monthStart) {
    final menstruationDays = <DateTime>[];
    final ovulationDays = <DateTime>[];

    var cycleStart = normalizedFirstDay;

    while (cycleStart.isAfter(monthStart)) {
      cycleStart = cycleStart.subtract(Duration(days: effectiveCycle));
    }

    final endSearch = DateTime(monthStart.year, monthStart.month + 1, 1)
        .add(Duration(days: effectiveCycle));

    while (cycleStart.isBefore(endSearch)) {
      for (int i = 0; i < effectiveMens; i++) {
        final mensDay = normalizeDate(cycleStart.add(Duration(days: i)));
        if (mensDay.year == monthStart.year &&
            mensDay.month == monthStart.month) {
          menstruationDays.add(mensDay);
        }
      }

      final ovulationOffset = (effectiveCycle - 14) - 1;
      for (int i = -4; i <= 2; i++) {
        final ovulationDay = normalizeDate(
          cycleStart.add(Duration(days: ovulationOffset + i)),
        );
        if (ovulationDay.year == monthStart.year &&
            ovulationDay.month == monthStart.month) {
          ovulationDays.add(ovulationDay);
        }
      }

      cycleStart = cycleStart.add(Duration(days: effectiveCycle));
    }

    final sortedOvulationDays = ovulationDays.toSet().toList()..sort();
    final cleanedMens = removeCollisions(
      menstruationDays,
      sortedOvulationDays,
    );

    return MonthCycleStruct(
      month: monthStart,
      menstruationDays: cleanedMens,
      ovulationDays: sortedOvulationDays,
      menstruationDuration: effectiveMens,
      cycleDuration: effectiveCycle,
    );
  }

  final monthCycleList = <MonthCycleStruct>[];
  var currentMonth = startMonth;

  while (!currentMonth.isAfter(endMonth)) {
    monthCycleList.add(generateMonthCycle(currentMonth));
    currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
  }

  return monthCycleList;
}

List<MonthCycleStruct> editDurationMonthCycle(
  int newCycleDuration,
  List<MonthCycleStruct> monthCycleList,
  DateTime? month,
  int newMenstruationDuration,
  DateTime? newStartDate,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  int effectiveMensDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 5;
  }

  DateTime? effectiveStartDate(DateTime? paramValue, List<DateTime> mensDays) {
    if (paramValue != null) return normalizeDate(paramValue);
    if (mensDays.isEmpty) return null;
    final normalized = mensDays.map(normalizeDate).toList()..sort();
    return normalized.first;
  }

  List<DateTime> buildMenstruationDays(DateTime start, int mensDur) {
    return List.generate(
      mensDur,
      (i) => normalizeDate(start.add(Duration(days: i))),
    )..sort();
  }

  List<DateTime> buildOvulationDays(DateTime start, int cycleDur) {
    final ovulationOffset = (cycleDur - 14) - 1;
    final central = start.add(Duration(days: ovulationOffset));
    return [
      for (int i = -4; i <= 2; i++)
        normalizeDate(central.add(Duration(days: i))),
    ]..sort();
  }

  List<DateTime> daysInMonth(List<DateTime> source, DateTime monthValue) {
    final monthStart = DateTime(monthValue.year, monthValue.month, 1);
    final monthEnd = DateTime(monthValue.year, monthValue.month + 1, 1);
    return source
        .map(normalizeDate)
        .where((d) => !d.isBefore(monthStart) && d.isBefore(monthEnd))
        .toList()
      ..sort();
  }

  List<DateTime> removeCollisions(
    List<DateTime> menstruationDays,
    List<DateTime> ovulationDays,
  ) {
    final ovulSet = ovulationDays.map(normalizeDate).toSet();
    return menstruationDays
        .map(normalizeDate)
        .where((d) => !ovulSet.contains(d))
        .toList()
      ..sort();
  }

  if (monthCycleList.isEmpty || newCycleDuration <= 0) return monthCycleList;

  final updatedList = List<MonthCycleStruct>.from(monthCycleList)
    ..sort((a, b) => a.month!.compareTo(b.month!));

  final now = DateTime.now();
  final targetMonth = month != null
      ? DateTime(month.year, month.month, 1)
      : DateTime(now.year, now.month, 1);

  final targetIndex = updatedList.indexWhere(
    (cycle) =>
        cycle.month != null &&
        cycle.month!.year == targetMonth.year &&
        cycle.month!.month == targetMonth.month,
  );
  if (targetIndex == -1) return updatedList;

  final target = updatedList[targetIndex];
  final effectiveMens = effectiveMensDuration(
    newMenstruationDuration,
    target.menstruationDuration,
  );
  final effectiveStart = effectiveStartDate(
    newStartDate,
    target.menstruationDays,
  );
  if (effectiveStart == null) return updatedList;

  final fullMens = buildMenstruationDays(effectiveStart, effectiveMens);
  final fullOvul = buildOvulationDays(effectiveStart, newCycleDuration);

  final targetOvul = daysInMonth(fullOvul, target.month!);
  final targetMens =
      removeCollisions(daysInMonth(fullMens, target.month!), targetOvul);

  updatedList[targetIndex] = MonthCycleStruct(
    month: target.month,
    menstruationDays: targetMens,
    ovulationDays: targetOvul,
    menstruationDuration: effectiveMens,
    cycleDuration: newCycleDuration,
  );

  if (targetIndex + 1 < updatedList.length) {
    final next = updatedList[targetIndex + 1];
    final spilloverMens = daysInMonth(fullMens, next.month!);
    final spilloverOvul = daysInMonth(fullOvul, next.month!);

    final mergedNextOvul = {
      ...next.ovulationDays.map(normalizeDate),
      ...spilloverOvul,
    }.toList()
      ..sort();

    final nextMensBase = [
      ...next.menstruationDays.map(normalizeDate),
      ...spilloverMens,
    ]..sort();

    final cleanedNextMens = removeCollisions(nextMensBase, mergedNextOvul);

    updatedList[targetIndex + 1] = MonthCycleStruct(
      month: next.month,
      menstruationDays: cleanedNextMens,
      ovulationDays: mergedNextOvul,
      menstruationDuration: cleanedNextMens.length,
      cycleDuration:
          next.cycleDuration > 0 ? next.cycleDuration : newCycleDuration,
    );
  }

  return updatedList;
}

List<MonthCycleStruct> removeDayToMensCycle(
  DateTime day,
  List<MonthCycleStruct> monthCycleList,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  int effectiveCycleDuration(int? structValue) {
    if (structValue != null && structValue > 0) return structValue;
    return 28;
  }

  List<DateTime> buildOvulationDays(DateTime start, int cycleDur) {
    final ovulationOffset = (cycleDur - 14) - 1;
    final central = start.add(Duration(days: ovulationOffset));
    return [
      for (int i = -4; i <= 2; i++)
        normalizeDate(central.add(Duration(days: i))),
    ]..sort();
  }

  List<DateTime> daysInMonth(List<DateTime> source, DateTime monthValue) {
    final monthStart = DateTime(monthValue.year, monthValue.month, 1);
    final monthEnd = DateTime(monthValue.year, monthValue.month + 1, 1);
    return source
        .map(normalizeDate)
        .where((d) => !d.isBefore(monthStart) && d.isBefore(monthEnd))
        .toList()
      ..sort();
  }

  List<DateTime> removeCollisions(
    List<DateTime> menstruationDays,
    List<DateTime> ovulationDays,
  ) {
    final ovulSet = ovulationDays.map(normalizeDate).toSet();
    return menstruationDays
        .map(normalizeDate)
        .where((d) => !ovulSet.contains(d))
        .toList()
      ..sort();
  }

  if (monthCycleList.isEmpty) return monthCycleList;

  final updatedList = List<MonthCycleStruct>.from(monthCycleList);
  final normalizedDay = normalizeDate(day);

  final monthIndex = updatedList.indexWhere(
    (cycle) =>
        cycle.month != null &&
        cycle.month!.year == normalizedDay.year &&
        cycle.month!.month == normalizedDay.month,
  );
  if (monthIndex == -1) return updatedList;

  final current = updatedList[monthIndex];

  final updatedMensDays = current.menstruationDays
      .map(normalizeDate)
      .where((d) => !(d.year == normalizedDay.year &&
          d.month == normalizedDay.month &&
          d.day == normalizedDay.day))
      .toList()
    ..sort();

  final cycleDur = effectiveCycleDuration(current.cycleDuration);

  if (updatedMensDays.isEmpty) {
    updatedList[monthIndex] = MonthCycleStruct(
      month: current.month,
      menstruationDays: [],
      ovulationDays: [],
      menstruationDuration: 0,
      cycleDuration: cycleDur,
    );
    return updatedList;
  }

  final firstMens = updatedMensDays.first;
  final fullOvul = buildOvulationDays(firstMens, cycleDur);
  final currentOvul = daysInMonth(fullOvul, current.month!);
  final cleanedCurrentMens = removeCollisions(updatedMensDays, currentOvul);

  updatedList[monthIndex] = MonthCycleStruct(
    month: current.month,
    menstruationDays: cleanedCurrentMens,
    ovulationDays: currentOvul,
    menstruationDuration: cleanedCurrentMens.length,
    cycleDuration: cycleDur,
  );

  if (monthIndex + 1 < updatedList.length) {
    final next = updatedList[monthIndex + 1];

    final spilloverInNext = daysInMonth(fullOvul, next.month!);
    final existingNextOvul = next.ovulationDays.map(normalizeDate).toList();
    final mergedNextOvul = {...existingNextOvul, ...spilloverInNext}.toList()
      ..sort();

    final cleanedNextMens =
        removeCollisions(next.menstruationDays, mergedNextOvul);

    updatedList[monthIndex + 1] = MonthCycleStruct(
      month: next.month,
      menstruationDays: cleanedNextMens,
      ovulationDays: mergedNextOvul,
      menstruationDuration: cleanedNextMens.length,
      cycleDuration: next.cycleDuration > 0 ? next.cycleDuration : cycleDur,
    );
  }

  return updatedList;
}

bool currentMonthInCalendarExist(List<MonthCycleStruct> monthCycleList) {
  // Получаем текущую дату
  DateTime now = DateTime.now();
  // Создаем DateTime для первого дня текущего месяца
  DateTime currentMonthStart = DateTime(now.year, now.month, 1);
  // Проверяем, существует ли цикл для текущего месяца и есть ли в нем дни менструации
  bool exists = monthCycleList.any((cycle) {
    // Проверяем, что месяц цикла не null и совпадает с текущим месяцем
    bool isCurrentMonth = cycle.month != null &&
        cycle.month!.year == currentMonthStart.year &&
        cycle.month!.month == currentMonthStart.month;

    // Проверяем, что в цикле есть дни менструации
    bool hasMenstruationDays =
        cycle.menstruationDays != null && cycle.menstruationDays!.isNotEmpty;

    // Возвращаем true, только если это текущий месяц и в нем есть дни менструации
    return isCurrentMonth && hasMenstruationDays;
  });
  return exists;
}

bool mensDayInDays(
  List<MonthCycleStruct> monthCycle,
  DateTime day,
) {
  for (var cycle in monthCycle) {
    if (cycle.menstruationDays != null) {
      for (var menstruationDay in cycle.menstruationDays!) {
        if (menstruationDay.year == day.year &&
            menstruationDay.month == day.month &&
            menstruationDay.day == day.day) {
          return true;
        }
      }
    }
  }
  return false;
}

List<MonthCycleStruct> addDayToMensCycle(
  List<MonthCycleStruct> monthCycleList,
  DateTime day,
  int? menstruationDuration,
  int? cycleDuration,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  int effectiveCycleDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 28;
  }

  int effectiveMensDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 5;
  }

  List<DateTime> buildOvulationDays(DateTime start, int cycleDur) {
    final ovulationOffset = (cycleDur - 14) - 1;
    final central = start.add(Duration(days: ovulationOffset));
    return [
      for (int i = -4; i <= 2; i++)
        normalizeDate(central.add(Duration(days: i))),
    ]..sort();
  }

  List<DateTime> daysInMonth(List<DateTime> source, DateTime month) {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 1);
    return source
        .map(normalizeDate)
        .where((d) => !d.isBefore(monthStart) && d.isBefore(monthEnd))
        .toList()
      ..sort();
  }

  List<DateTime> removeCollisions(
    List<DateTime> menstruationDays,
    List<DateTime> ovulationDays,
  ) {
    final ovulSet = ovulationDays.map(normalizeDate).toSet();
    return menstruationDays
        .map(normalizeDate)
        .where((d) => !ovulSet.contains(d))
        .toList()
      ..sort();
  }

  if (monthCycleList.isEmpty) return monthCycleList;

  final updatedList = List<MonthCycleStruct>.from(monthCycleList);
  final normalizedDay = normalizeDate(day);

  final selectedMonthIndex = updatedList.indexWhere(
    (cycle) =>
        cycle.month != null &&
        cycle.month!.year == normalizedDay.year &&
        cycle.month!.month == normalizedDay.month,
  );
  if (selectedMonthIndex == -1) return updatedList;

  final current = updatedList[selectedMonthIndex];
  final existingMens = current.menstruationDays.map(normalizeDate).toList();

  if (existingMens.contains(normalizedDay)) return updatedList;

  final updatedMens = [...existingMens, normalizedDay]..sort();

  final effectiveCycle = effectiveCycleDuration(
    cycleDuration,
    current.cycleDuration,
  );
  final effectiveMens = effectiveMensDuration(
    menstruationDuration,
    current.menstruationDuration,
  );
  final effectiveStart = updatedMens.first;

  final fullOvul = buildOvulationDays(effectiveStart, effectiveCycle);
  final currentOvul = daysInMonth(fullOvul, current.month!);
  final cleanedCurrentMens = removeCollisions(updatedMens, currentOvul);

  updatedList[selectedMonthIndex] = MonthCycleStruct(
    month: current.month,
    menstruationDays: cleanedCurrentMens,
    ovulationDays: currentOvul,
    menstruationDuration: effectiveMens,
    cycleDuration: effectiveCycle,
  );

  if (selectedMonthIndex + 1 < updatedList.length) {
    final next = updatedList[selectedMonthIndex + 1];

    final spilloverInNext = daysInMonth(fullOvul, next.month!);
    final existingNextOvul = next.ovulationDays.map(normalizeDate).toList();
    final mergedNextOvul = {...existingNextOvul, ...spilloverInNext}.toList()
      ..sort();

    final cleanedNextMens =
        removeCollisions(next.menstruationDays, mergedNextOvul);

    updatedList[selectedMonthIndex + 1] = MonthCycleStruct(
      month: next.month,
      menstruationDays: cleanedNextMens,
      ovulationDays: mergedNextOvul,
      menstruationDuration: cleanedNextMens.length,
      cycleDuration:
          next.cycleDuration > 0 ? next.cycleDuration : effectiveCycle,
    );
  }

  return updatedList;
}

List<MonthCycleStruct> addStartDayToMensCycle(
  List<MonthCycleStruct> monthCycleList,
  DateTime day,
  int? cycleDuration,
  int? menstruationDuration,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  int effectiveCycleDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 28;
  }

  int effectiveMensDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 5;
  }

  List<DateTime> buildMenstruationDays(DateTime start, int mensDur) {
    return List.generate(
      mensDur,
      (i) => normalizeDate(start.add(Duration(days: i))),
    )..sort();
  }

  List<DateTime> buildOvulationDays(DateTime start, int cycleDur) {
    final ovulationOffset = (cycleDur - 14) - 1;
    final central = start.add(Duration(days: ovulationOffset));
    return [
      for (int i = -4; i <= 2; i++)
        normalizeDate(central.add(Duration(days: i))),
    ]..sort();
  }

  List<DateTime> daysInMonth(List<DateTime> source, DateTime month) {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 1);
    return source
        .map(normalizeDate)
        .where((d) => !d.isBefore(monthStart) && d.isBefore(monthEnd))
        .toList()
      ..sort();
  }

  List<DateTime> removeCollisions(
    List<DateTime> menstruationDays,
    List<DateTime> ovulationDays,
  ) {
    final ovulSet = ovulationDays.map(normalizeDate).toSet();
    return menstruationDays
        .map(normalizeDate)
        .where((d) => !ovulSet.contains(d))
        .toList()
      ..sort();
  }

  if (monthCycleList.isEmpty) return monthCycleList;

  final updatedList = List<MonthCycleStruct>.from(monthCycleList);
  final selectedMonthIndex = updatedList.indexWhere(
    (c) =>
        c.month != null &&
        c.month!.year == day.year &&
        c.month!.month == day.month,
  );
  if (selectedMonthIndex == -1) return updatedList;

  final current = updatedList[selectedMonthIndex];
  final effectiveCycle = effectiveCycleDuration(
    cycleDuration,
    current.cycleDuration,
  );
  final effectiveMens = effectiveMensDuration(
    menstruationDuration,
    current.menstruationDuration,
  );
  final effectiveStart = normalizeDate(day);

  final fullMens = buildMenstruationDays(effectiveStart, effectiveMens);
  final fullOvul = buildOvulationDays(effectiveStart, effectiveCycle);

  final currentOvul = daysInMonth(fullOvul, current.month!);
  final currentMens = removeCollisions(
    daysInMonth(fullMens, current.month!),
    currentOvul,
  );

  updatedList[selectedMonthIndex] = MonthCycleStruct(
    month: current.month,
    menstruationDays: currentMens,
    ovulationDays: currentOvul,
    menstruationDuration: effectiveMens,
    cycleDuration: effectiveCycle,
  );

  if (selectedMonthIndex + 1 < updatedList.length) {
    final next = updatedList[selectedMonthIndex + 1];

    final spilloverMens = daysInMonth(fullMens, next.month!);
    final spilloverOvul = daysInMonth(fullOvul, next.month!);
    final mergedNextOvul = {
      ...next.ovulationDays.map(normalizeDate),
      ...spilloverOvul,
    }.toList()
      ..sort();

    final nextMensBase = [
      ...next.menstruationDays.map(normalizeDate),
      ...spilloverMens,
    ]..sort();

    final cleanedNextMens = removeCollisions(nextMensBase, mergedNextOvul);

    updatedList[selectedMonthIndex + 1] = MonthCycleStruct(
      month: next.month,
      menstruationDays: cleanedNextMens,
      ovulationDays: mergedNextOvul,
      menstruationDuration: cleanedNextMens.length,
      cycleDuration:
          next.cycleDuration > 0 ? next.cycleDuration : effectiveCycle,
    );
  }

  return updatedList;
}

List<MonthCycleStruct> addEndDayToMensCycle(
  List<MonthCycleStruct> monthCycleList,
  DateTime day,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  if (monthCycleList.isEmpty) return monthCycleList;

  final updatedList = List<MonthCycleStruct>.from(monthCycleList);
  final normalizedDay = normalizeDate(day);

  final selectedMonthIndex = updatedList.indexWhere(
    (c) =>
        c.month != null &&
        c.month!.year == normalizedDay.year &&
        c.month!.month == normalizedDay.month,
  );
  if (selectedMonthIndex == -1) return updatedList;

  final current = updatedList[selectedMonthIndex];
  final existingDays = current.menstruationDays.map(normalizeDate).toList()
    ..sort();

  if (existingDays.isEmpty) return updatedList;

  final firstDay = existingDays.first;
  final newMensDays = <DateTime>[];
  var cursor = firstDay;

  while (!cursor.isAfter(normalizedDay)) {
    newMensDays.add(normalizeDate(cursor));
    cursor = cursor.add(const Duration(days: 1));
  }

  updatedList[selectedMonthIndex] = MonthCycleStruct(
    month: current.month,
    menstruationDays: newMensDays,
    ovulationDays: current.ovulationDays,
    menstruationDuration: newMensDays.length,
    cycleDuration: current.cycleDuration,
  );

  return updatedList;
}

bool ovulationDayInDays(
  DateTime day,
  List<MonthCycleStruct> monthCycle,
) {
  for (var cycle in monthCycle) {
    if (cycle.ovulationDays != null) {
      for (var ovulationDay in cycle.ovulationDays!) {
        if (ovulationDay.year == day.year &&
            ovulationDay.month == day.month &&
            ovulationDay.day == day.day) {
          return true;
        }
      }
    }
  }
  return false;
}

bool ovulationCentralDayInDays(
  DateTime day,
  List<MonthCycleStruct> monthCycle,
) {
  final dayOnly = DateTime(day.year, day.month, day.day);

  // Collect ALL menstruation start dates across all months.
  // A "cycle start" is the first day of a contiguous menstruation run.
  // Using all months allows correct handling when ovulation window is split
  // across month boundaries (saved partially in two months).
  final List<DateTime> allMensDays = [];
  for (final cycle in monthCycle) {
    for (final d in cycle.menstruationDays) {
      allMensDays.add(DateTime(d.year, d.month, d.day));
    }
  }
  allMensDays.sort();

  // Identify cycle start days = first day of each contiguous menstruation run.
  // Any mens day without a previous day immediately before it is a cycle start.
  final Set<DateTime> mensSet = allMensDays.toSet();
  final List<DateTime> cycleStarts = [];
  for (final d in allMensDays) {
    final prev = DateTime(d.year, d.month, d.day - 1);
    if (!mensSet.contains(prev)) {
      cycleStarts.add(d);
    }
  }

  // For each cycle, compute the central ovulation day using the formula:
  //   central = cycleStart + (cycleDuration - 14) - 1
  // 28-day cycle → day 14 → offset +13
  // 25-day cycle → day 11 → offset +10
  // 30-day cycle → day 16 → offset +15
  for (final start in cycleStarts) {
    // Find the cycleDuration associated with this start (from the month it belongs to)
    int cycleDur = 28; // fallback
    for (final cycle in monthCycle) {
      if (cycle.month != null &&
          cycle.month!.year == start.year &&
          cycle.month!.month == start.month &&
          cycle.cycleDuration > 0) {
        cycleDur = cycle.cycleDuration;
        break;
      }
    }

    final int offset = (cycleDur - 14) - 1;
    final central = start.add(Duration(days: offset));
    if (central.year == dayOnly.year &&
        central.month == dayOnly.month &&
        central.day == dayOnly.day) {
      return true;
    }
  }

  // Fallback for cases where menstruation data is missing but ovulation is predicted.
  // Standard fertile window is 7 days with the central ovulation day = 5th of 7
  // (4 days before + central + 2 days after). This fallback tries to recover
  // the central day when the window is fully stored in one cycle entry.
  if (cycleStarts.isEmpty) {
    for (final cycle in monthCycle) {
      if (cycle.ovulationDays.isEmpty) continue;
      final ovul = cycle.ovulationDays
          .map((d) => DateTime(d.year, d.month, d.day))
          .toList()
        ..sort();

      // Only trust this fallback for a single contiguous run (no gaps).
      // A gap > 1 day means there are probably multiple cycles in this entry.
      bool contiguous = true;
      for (int i = 1; i < ovul.length; i++) {
        if (ovul[i].difference(ovul[i - 1]).inDays != 1) {
          contiguous = false;
          break;
        }
      }
      if (!contiguous) continue;

      // If the full 7-day window is present — pick the 5th element (index 4).
      // For smaller fragments (e.g. window cropped by month boundary) we can
      // only guess, so skip to avoid false positives.
      if (ovul.length == 7) {
        final central = ovul[4]; // 5th of 7
        if (central.isAtSameMomentAs(dayOnly)) return true;
      }
    }
  }

  return false;
}

int ovulationDayInDaysNumber(
  DateTime day,
  List<MonthCycleStruct> monthCycle,
) {
  final dayOnly = DateTime(day.year, day.month, day.day);

  final List<DateTime> allOvulationDays = [];

  for (final cycle in monthCycle) {
    for (final d in cycle.ovulationDays) {
      allOvulationDays.add(DateTime(d.year, d.month, d.day));
    }
  }

  if (allOvulationDays.isEmpty) {
    return 0;
  }

  allOvulationDays.sort();

  final List<DateTime> uniqueOvulationDays = [];
  for (final d in allOvulationDays) {
    if (uniqueOvulationDays.isEmpty ||
        !uniqueOvulationDays.last.isAtSameMomentAs(d)) {
      uniqueOvulationDays.add(d);
    }
  }

  final List<List<DateTime>> ovulationWindows = [];
  List<DateTime> currentWindow = [];

  for (final d in uniqueOvulationDays) {
    if (currentWindow.isEmpty) {
      currentWindow.add(d);
      continue;
    }

    final prev = currentWindow.last;
    if (d.difference(prev).inDays == 1) {
      currentWindow.add(d);
    } else {
      ovulationWindows.add(currentWindow);
      currentWindow = [d];
    }
  }

  if (currentWindow.isNotEmpty) {
    ovulationWindows.add(currentWindow);
  }

  for (final window in ovulationWindows) {
    for (int i = 0; i < window.length; i++) {
      final ovulationDay = window[i];
      if (ovulationDay.year == dayOnly.year &&
          ovulationDay.month == dayOnly.month &&
          ovulationDay.day == dayOnly.day) {
        return i + 1;
      }
    }
  }

  return 0;
}

int cycleDay(
  DateTime day,
  List<MonthCycleStruct> monthCycle,
) {
  final dayOnly = DateTime(day.year, day.month, day.day);

  if (monthCycle.isEmpty) return 0;

  // Sort all cycles chronologically
  final sorted = List<MonthCycleStruct>.from(monthCycle)
    ..sort(
        (a, b) => (a.month ?? DateTime(0)).compareTo(b.month ?? DateTime(0)));

  // Find any cycle with menstruation days — prefer last one before dayOnly,
  // fallback to earliest available
  MonthCycleStruct? refCycle;

  // First try: last cycle with mens days at or before dayOnly
  for (int i = sorted.length - 1; i >= 0; i--) {
    if (sorted[i].menstruationDays.isNotEmpty) {
      final firstDay = sorted[i]
          .menstruationDays
          .map((d) => DateTime(d.year, d.month, d.day))
          .reduce((a, b) => a.isBefore(b) ? a : b);
      if (!firstDay.isAfter(dayOnly)) {
        refCycle = sorted[i];
        break;
      }
    }
  }

  // Second try: no cycle before dayOnly — use the earliest available
  if (refCycle == null) {
    for (int i = 0; i < sorted.length; i++) {
      if (sorted[i].menstruationDays.isNotEmpty) {
        refCycle = sorted[i];
        break;
      }
    }
  }

  if (refCycle == null) return 0;

  final int cycleDuration = refCycle.cycleDuration ?? 28;

  // Get reference cycle start
  final DateTime refStart = refCycle.menstruationDays
      .map((d) => DateTime(d.year, d.month, d.day))
      .reduce((a, b) => a.isBefore(b) ? a : b);

  // Step forward/backward by cycleDuration to find cycleStart <= dayOnly
  DateTime cycleStart = refStart;

  if (cycleStart.isAfter(dayOnly)) {
    // Ref is in the future — step backward
    while (cycleStart.isAfter(dayOnly)) {
      cycleStart = cycleStart.subtract(Duration(days: cycleDuration));
    }
  } else {
    // Ref is in the past — step forward until next step would exceed dayOnly
    while (true) {
      final next = cycleStart.add(Duration(days: cycleDuration));
      if (next.isAfter(dayOnly)) break;
      cycleStart = next;
    }
  }

  return dayOnly.difference(cycleStart).inDays + 1;
}

bool dayGreatherThanToday(DateTime? day) {
// Return false if day is null
  if (day == null) {
    return false;
  }

  // Get current date without time (only date part)
  DateTime now = DateTime.now();
  DateTime currentDay = DateTime(now.year, now.month, now.day);

  // Get the input day without time (only date part)
  DateTime inputDay = DateTime(day.year, day.month, day.day);

  // Return true if input day is after current day
  return inputDay.isAfter(currentDay);
}

DateTime startMensDay(
  List<MonthCycleStruct> monthCycle,
  DateTime currentMonth,
) {
  final today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  if (monthCycle.isEmpty) return today;

  // Collect all menstruation and ovulation days across ALL months.
  // Using all months handles cases where a run spans across a month boundary.
  final Set<DateTime> mensSet = {};
  final Set<DateTime> ovulSet = {};
  for (final cycle in monthCycle) {
    for (final d in cycle.menstruationDays) {
      mensSet.add(DateTime(d.year, d.month, d.day));
    }
    for (final d in cycle.ovulationDays) {
      ovulSet.add(DateTime(d.year, d.month, d.day));
    }
  }

  // --- Case 1: Today is an OVULATION day → first day of this ovulation window ---
  if (ovulSet.contains(today)) {
    DateTime d = today;
    while (ovulSet.contains(DateTime(d.year, d.month, d.day - 1))) {
      d = DateTime(d.year, d.month, d.day - 1);
    }
    return d;
  }

  // --- Case 2: Today is a MENSTRUATION day → first day of this mens run ---
  if (mensSet.contains(today)) {
    DateTime d = today;
    while (mensSet.contains(DateTime(d.year, d.month, d.day - 1))) {
      d = DateTime(d.year, d.month, d.day - 1);
    }
    return d;
  }

  // --- Case 3: Otherwise → start of the NEXT menstruation ---
  final List<DateTime> cycleStarts = [];
  final sortedMens = mensSet.toList()..sort();
  for (final d in sortedMens) {
    final prev = DateTime(d.year, d.month, d.day - 1);
    if (!mensSet.contains(prev)) {
      cycleStarts.add(d);
    }
  }
  cycleStarts.sort();

  for (final s in cycleStarts) {
    if (s.isAfter(today)) return s;
  }

  // No future mens data found — return today as a safe fallback
  return today;
}

String? nameHome(
  String? name,
  String? surname,
) {
  bool hasName = name != null && name.trim().isNotEmpty;
  bool hasSurname = surname != null && surname.trim().isNotEmpty;

  if (!hasName && !hasSurname) return "МИЛАЯ";

  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + (text.length > 1 ? text.substring(1) : '');
  }

  if (hasName && hasSurname) {
    String surnameInitial = surname!.trim()[0].toUpperCase();
    String nameCapitalized = capitalizeFirst(name!.trim());
    return '$nameCapitalized $surnameInitial.'.toUpperCase();
  }

  if (hasName) return capitalizeFirst(name!.trim()).toUpperCase();
  if (hasSurname) return capitalizeFirst(surname!.trim()).toUpperCase();

  return "МИЛАЯ";
}

String nameLettters(
  String? name,
  String? surname,
) {
  // Trim and check if values exist
  String? trimmedName = name?.trim();
  String? trimmedSurname = surname?.trim();

  bool hasName = trimmedName != null && trimmedName.isNotEmpty;
  bool hasSurname = trimmedSurname != null && trimmedSurname.isNotEmpty;

  // If both name and surname exist
  if (hasName && hasSurname) {
    String nameInitial = trimmedName![0].toUpperCase();
    String surnameInitial = trimmedSurname![0].toUpperCase();
    return '$nameInitial$surnameInitial';
  }

  // If only name exists, check if it has multiple words
  if (hasName) {
    List<String> nameParts =
        trimmedName!.split(' ').where((part) => part.isNotEmpty).toList();

    if (nameParts.length >= 2) {
      // Name has 2+ words: take first letter of first two words
      String firstInitial = nameParts[0][0].toUpperCase();
      String secondInitial = nameParts[1][0].toUpperCase();
      return '$firstInitial$secondInitial';
    } else {
      // Single word name: repeat first two letters or first letter twice
      if (trimmedName.length >= 2) {
        return trimmedName.substring(0, 2).toUpperCase();
      } else {
        // Single letter name
        String letter = trimmedName[0].toUpperCase();
        return '$letter$letter';
      }
    }
  }

  // If only surname exists
  if (hasSurname) {
    // Take first two letters of surname or repeat first letter
    if (trimmedSurname!.length >= 2) {
      return trimmedSurname.substring(0, 2).toUpperCase();
    } else {
      String letter = trimmedSurname[0].toUpperCase();
      return '$letter$letter';
    }
  }

  // Default: if both are empty
  return 'WN';
}

List<String> pressets() {
  return [
    'Куда пропадает энергия?',
    'Как полюбить себя?',
    'Как правильно медитировать?',
    'Что такое духовный рост?',
    'Как построить счастливые отношения?',
    'Что такое доверие к миру?',
    'Как встретить того самого мужчину?',
  ];
}

String dateTextNow() {
  // Get current hour
  final int currentHour = DateTime.now().hour;

  // Return greeting with emoji based on time of day
  // Morning: 6:00 - 11:59 ☀️
  // Day: 12:00 - 17:59 🌤️
  // Evening: 18:00 - 22:59 🌙
  // Night: 23:00 - 5:59 🌃

  if (currentHour >= 6 && currentHour < 12) {
    return 'ДОБРОЕ УТРО! ☀️';
  } else if (currentHour >= 12 && currentHour < 18) {
    return 'ДОБРЫЙ ДЕНЬ! 🌤️';
  } else if (currentHour >= 18 && currentHour < 23) {
    return 'ДОБРЫЙ ВЕЧЕР! 🌙';
  } else {
    return 'ДОБРОЙ НОЧИ! 🌃';
  }
}

DateTime startDay() {
  // start current date
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, 00, 00, 01);
}

DateTime endDay() {
  // end of current date
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, 23, 59, 59);
}

String? createCloudPaymentsWebViewSubs(
  String? orderId,
  String? email,
  String? clientId,
  String? description,
  double? amount,
  String? publicId,
  String? currency,
  bool? isPackageMode,
  bool isRecurrent,
  String? recurrentInterval,
  int? recurrentPeriod,
  double? recurrentAmount,
  DateTime? recurrentStartDate,
  Color? bgColor,
  Color? inpBg,
  Color? inpBorderCol,
  Color? textColor,
  Color? buttonColor,
  Color? buttonTextColor,
  Color? errorColor,
  Color? inputTextColor,
  bool isTrialSubscription,
  int? trialDays,
  int taxationSystem,
  String? vat,
) {
  String colorToHex(Color? color) {
    if (color == null) return '';
    if (color.alpha == 0) return 'transparent';
    // Use rgba() format for colors with transparency — better CSS support
    if (color.alpha < 255) {
      final double a = color.alpha / 255.0;
      return 'rgba(${color.red},${color.green},${color.blue},${a.toStringAsFixed(2)})';
    }
    return '#${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  // ────────────────────────────────────────────────────────────────────────

  final String bgColorHex =
      bgColor != null ? colorToHex(bgColor) : 'transparent';
  final String inpBgHex = inpBg != null ? colorToHex(inpBg) : '#1FFFFFFF';
  final String inpBorderColHex =
      inpBorderCol != null ? colorToHex(inpBorderCol) : '#1FFFFFFF';

  final String textColorHex =
      textColor != null ? colorToHex(textColor) : '#FFD6AA';

  final String inputLabelColorHex = inputTextColor != null
      ? colorToHex(inputTextColor)
      : 'rgba(255,214,170,0.64)';

  final String inputValueColorHex = '#FFD6AA';

  final String buttonColorHex =
      buttonColor != null ? colorToHex(buttonColor) : '#DA7036';

  final String buttonTextColorHex =
      buttonTextColor != null ? colorToHex(buttonTextColor) : '#FFD6AA';
  final String errorColorHex =
      errorColor != null ? colorToHex(errorColor) : '#E8B542';

  final int actualTrialDays = trialDays ?? 3;
  final String actualPublicId = (publicId != null && publicId.isNotEmpty)
      ? publicId
      : 'pk_d07912a5de0f0bbad69bb4889e3be';
  final double actualAmount = amount ?? 1500.0;
  final int actualRecurrentPeriod = recurrentPeriod ?? 1;
  final String actualRecurrentInterval = recurrentInterval ?? 'Month';
  final double actualRecurrentAmount = recurrentAmount ?? 1500.0;
  final int actualTaxationSystem = taxationSystem ?? 1;

  final String vatValue = (vat == null || vat.isEmpty) ? 'null' : vat;

  if (actualPublicId.isEmpty) {
    return '''<!DOCTYPE html>
<html lang="ru">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body style="background-color: $bgColorHex; color: $textColorHex; padding: 20px; text-align: center;">
  <p>Ошибка: не указан публичный ключ CloudPayments</p>
</body>
</html>''';
  }

  if (actualAmount <= 0) {
    return '''<!DOCTYPE html>
<html lang="ru">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body style="background-color: $bgColorHex; color: $textColorHex; padding: 20px; text-align: center;">
  <p>Ошибка: неверная сумма платежа</p>
</body>
</html>''';
  }

  double initialAmount = isTrialSubscription ? 1.0 : actualRecurrentAmount;
  double regularAmount = actualRecurrentAmount;

  if (isRecurrent) {
    if (actualRecurrentPeriod <= 0) {
      return '''<!DOCTYPE html>
<html lang="ru">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body style="background-color: $bgColorHex; color: $textColorHex; padding: 20px; text-align: center;">
  <p>Ошибка: не указан период подписки</p>
</body>
</html>''';
    }

    if (actualRecurrentInterval.isEmpty) {
      return '''<!DOCTYPE html>
<html lang="ru">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body style="background-color: $bgColorHex; color: $textColorHex; padding: 20px; text-align: center;">
  <p>Ошибка: не указан интервал подписки</p>
</body>
</html>''';
    }

    if (regularAmount <= 0) {
      return '''<!DOCTYPE html>
<html lang="ru">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body style="background-color: $bgColorHex; color: $textColorHex; padding: 20px; text-align: center;">
  <p>Ошибка: неверная сумма регулярного платежа</p>
</body>
</html>''';
    }
  }

  final DateTime orderDate = DateTime.now();
  final DateTime subscriptionStartDate = orderDate;

  DateTime firstPaymentDate;
  if (isTrialSubscription && isRecurrent) {
    firstPaymentDate = orderDate.add(Duration(days: actualTrialDays));
  } else {
    firstPaymentDate = orderDate;
  }

  DateTime subscriptionEndDate;
  if (actualRecurrentInterval == 'Month') {
    subscriptionEndDate = DateTime(
      subscriptionStartDate.year,
      subscriptionStartDate.month + actualRecurrentPeriod,
      subscriptionStartDate.day,
    );
  } else {
    subscriptionEndDate = subscriptionStartDate;
  }

  String formattedStartDate = "";
  if (recurrentStartDate != null) {
    formattedStartDate =
        "${recurrentStartDate.year}-${recurrentStartDate.month.toString().padLeft(2, '0')}-${recurrentStartDate.day.toString().padLeft(2, '0')}T00:00:00";
  } else if (isRecurrent && isTrialSubscription) {
    formattedStartDate =
        "${firstPaymentDate.year}-${firstPaymentDate.month.toString().padLeft(2, '0')}-${firstPaymentDate.day.toString().padLeft(2, '0')}T00:00:00";
  }

  String getDayDeclension(int days) {
    int lastDigit = days % 10;
    int lastTwoDigits = days % 100;
    if (lastTwoDigits >= 11 && lastTwoDigits <= 14) return 'дней';
    if (lastDigit == 1) return 'день';
    if (lastDigit >= 2 && lastDigit <= 4) return 'дня';
    return 'дней';
  }

  String displayDescription = description ?? '';
  String? initialDescription;

  if (isTrialSubscription && isRecurrent) {
    String monthlyPriceText = '';
    if (actualRecurrentPeriod > 1) {
      int monthlyPrice = (regularAmount / actualRecurrentPeriod).round();
      monthlyPriceText = ' ($monthlyPrice ₽ в месяц)';
    }

    String periodText = '';
    if (actualRecurrentInterval == 'Month') {
      periodText = actualRecurrentPeriod == 1
          ? 'месяц'
          : (actualRecurrentPeriod == 12
              ? 'год'
              : '$actualRecurrentPeriod месяца');
    } else {
      periodText = actualRecurrentInterval;
    }

    int regularPrice = regularAmount.round();
    int trialPrice = initialAmount.round();
    displayDescription =
        '$description ($actualTrialDays ${getDayDeclension(actualTrialDays)} за $trialPrice ₽, затем $regularPrice ₽ в $periodText$monthlyPriceText)';

    initialDescription =
        '$description (Списание 1 ₽ для подтверждения подписки)';
  }

  String formatSubscriptionEndDate() {
    if (!isRecurrent) return '';
    DateTime expirationDate =
        isTrialSubscription ? firstPaymentDate : subscriptionEndDate;
    List<String> months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];
    return '${expirationDate.day} ${months[expirationDate.month - 1]} ${expirationDate.year}';
  }

  String generateSubscriptionText() {
    if (!isRecurrent) return '';
    String endDateText = formatSubscriptionEndDate();
    int regularPrice = regularAmount.round();
    String priceText = '$regularPrice ₽';

    String periodText = '';
    if (actualRecurrentInterval == 'Month') {
      if (actualRecurrentPeriod == 1) {
        periodText = 'в месяц';
      } else if (actualRecurrentPeriod == 12) {
        periodText = 'в год';
        int monthlyPrice = (regularAmount / 12).round();
        priceText = '$regularPrice ₽ в год ($monthlyPrice ₽ в месяц)';
      } else {
        periodText = 'за $actualRecurrentPeriod месяца';
      }
    }

    String trialText;
    if (isTrialSubscription) {
      trialText =
          '$actualTrialDays ${getDayDeclension(actualTrialDays)} за ${initialAmount.round()} ₽ — потом $priceText';
    } else {
      if (actualRecurrentPeriod == 12) {
        trialText = 'всего за $priceText';
      } else if (periodText.isNotEmpty) {
        trialText = 'всего за $priceText $periodText';
      } else {
        trialText = 'всего за $priceText';
      }
    }

    String cafeText = isTrialSubscription
        ? 'Получите все возможности приложения по цене похода в кафе. '
        : 'Получите все возможности приложения по цене похода в кафе ';
    return 'Подписка будет активна до $endDateText года. $cafeText$trialText';
  }

  String subscriptionInfoText = generateSubscriptionText();

  String escapedDescription = displayDescription.replaceAll("'", "\\'");
  String escapedInitialDescription =
      (initialDescription ?? displayDescription).replaceAll("'", "\\'");
  String escapedSubscriptionInfo = subscriptionInfoText.replaceAll("'", "\\'");

  String content = '''
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    html, body {
      margin: 0;
      padding: 0;
      background-color: $bgColorHex;
      height: 100%;
      width: 100%;
      overflow: hidden;
    }

    #element {
      background-color: $bgColorHex;
      width: 100%;
      height: 100%;
      padding: 0;
      margin: 0;
      box-sizing: border-box;
    }

    /* ── Все контейнеры — фон страницы ── */
    .cp-payment-page,
    .cp-payment-container,
    .payment-form-container,
    .payment-form,
    .payment-block,
    div, form, section {
      background-color: $bgColorHex !important;
    }

    /* ── Заголовок / основной текст ── */
    /* Figma Title/XL: Inter 500 28px, letter-spacing -0.06em, uppercase, rgba(255,214,170,0.88) */
    .cp-payment-title,
    h1, h2, h3 {
      font-family: 'Inter', -apple-system, sans-serif !important;
      font-weight: 500 !important;
      font-size: 28px !important;
      line-height: 32px !important;
      letter-spacing: -0.06em !important;
      text-transform: uppercase !important;
      color: $textColorHex !important;
    }

    /* ── Подзаголовок ── */
    /* Figma Body/MD: Inter 400 17px, line-height 24px, letter-spacing -0.05em, rgba(255,214,170,0.64) */
    .cp-payment-description,
    .cp-payment-subtitle,
    p {
      font-family: 'Inter', -apple-system, sans-serif !important;
      font-weight: 400 !important;
      font-size: 17px !important;
      line-height: 24px !important;
      letter-spacing: -0.05em !important;
      color: $inputLabelColorHex !important;
    }

    /* ── Лейбл инпута (floating label) ── */
    /* Figma Body/SM: Inter 400 15px, line-height 18px, letter-spacing -0.05em, rgba(255,214,170,0.64) */
    label,
    .cp-label,
    .cp-payment-label,
    span.label {
      font-family: 'Inter', -apple-system, sans-serif !important;
      font-weight: 400 !important;
      font-size: 15px !important;
      line-height: 18px !important;
      letter-spacing: -0.05em !important;
      color: $inputLabelColorHex !important;
    }

    /* ── Инпуты ── */
    /* Figma: bg rgba(255,255,255,0.12), border-radius 16px, нет border */
    input,
    select,
    textarea,
    .cp-payment-input {
      font-family: 'Inter', -apple-system, sans-serif !important;
      font-weight: 400 !important;
      font-size: 17px !important;
      line-height: 24px !important;
      letter-spacing: -0.05em !important;
      color: $inputValueColorHex !important;
      background-color: $inpBgHex !important;
      border: none !important;
      border-radius: 16px !important;
      padding: 8px 16px !important;
    }

    /* ── Кнопка оплаты ── */
    /* Figma: bg #DA7036, border-radius 56px, Inter 600 17px uppercase, rgba(255,214,170,0.88) */
    button[type="submit"],
    .cp-payment-button,
    .cp-btn-primary,
    [class*="pay-button"],
    [class*="submit-button"] {
      font-family: 'Inter', -apple-system, sans-serif !important;
      font-weight: 600 !important;
      font-size: 17px !important;
      line-height: 22px !important;
      letter-spacing: -0.06em !important;
      text-transform: uppercase !important;
      color: $buttonTextColorHex !important;
      background-color: $buttonColorHex !important;
      border-radius: 56px !important;
      border: none !important;
      padding: 16px 20px !important;
      width: 100% !important;
    }

    button[type="submit"]:hover,
    .cp-payment-button:hover,
    .cp-btn-primary:hover {
      background-color: $buttonColorHex !important;
      opacity: 0.9;
    }

    /* ── Subscription info ── */
    /* Figma Body/SM: Inter 400 15px, line-height 18px, letter-spacing -0.05em, rgba(255,214,170,0.64), text-align center */
    .subscription-info {
      padding: 8px 20px;
      margin-top: 8px;
      text-align: center;
    }

    .subscription-info p {
      font-family: 'Inter', -apple-system, sans-serif !important;
      font-size: 15px !important;
      line-height: 18px !important;
      letter-spacing: -0.05em !important;
      color: $inputLabelColorHex !important;
      margin: 0;
      text-align: center;
    }
  </style>
  <script src="https://widget.cloudpayments.ru/bundles/paymentblocks.js"></script>
</head>
<body>
  <div id="element"></div>
  <script>
  try {
  var blocksApp = new cp.PaymentBlocks({
      publicId: '$actualPublicId',
      description: '$escapedDescription',
      amount: $initialAmount,
      currency: '${currency ?? 'RUB'}',
      invoiceId: '${orderId ?? ''}',
      accountId: '${clientId ?? ''}',
      email: '${email ?? ''}',
      requireEmail: false,
      language: 'ru-RU',
      applePaySupport: true,
      googlePaySupport: true,
      yandexPaySupport: false,
      data: {
         email: '${email ?? ''}',
         isPackageMode: '${isPackageMode ?? false}',
         isTrialSubscription: '$isTrialSubscription',
         trialDays: '$actualTrialDays',
         recurrentPeriod: '$actualRecurrentPeriod',
         recurrentInterval: '$actualRecurrentInterval',
         CloudPayments: {
              customerReceipt: {
                  Items: [
                      {
                          label: '$escapedInitialDescription',
                          price: $initialAmount,
                          quantity: 1.00,
                          amount: $initialAmount,
                          vat: $vatValue,
                          method: 4,
                          object: 4
                      }
                  ],
                  taxationSystem: $actualTaxationSystem,
                  email: '${email ?? ''}',
                  amounts: { electronic: $initialAmount }
                },${(isRecurrent == true) ? '''
              recurrent: {
                  interval: '$actualRecurrentInterval',
                  period: $actualRecurrentPeriod,
                  amount: $regularAmount${formattedStartDate.isNotEmpty ? ",startDate: '$formattedStartDate'" : ""},
                  customerReceipt: {
                      Items: [
                          {
                              label: '$escapedDescription',
                              price: $regularAmount,
                              quantity: 1.00,
                              amount: $regularAmount,
                              vat: $vatValue,
                              method: 4,
                              object: 4
                          }
                      ],
                      taxationSystem: $actualTaxationSystem,
                      email: '${email ?? ''}',
                      amounts: { electronic: $regularAmount }
                  }
              }''' : ''}
          }
      }
  }, {
      appearance: {
        background: "$bgColorHex",
        colors: {
          // Кнопка — Figma: #DA7036
          primaryButtonColor: "$buttonColorHex",
          primaryButtonTextColor: "$buttonTextColorHex",
          primaryHoverButtonColor: "$buttonColorHex",
          primaryButtonHoverTextColor: "$buttonTextColorHex",
          // Инпуты — Figma: rgba(255,255,255,0.12), без border
          activeInputColor: "$inputValueColorHex",
          inputBackground: "$inpBgHex",
          inputColor: "$inputValueColorHex",
          inputBorderColor: "transparent",
          // Прочее
          errorColor: "$errorColorHex",
          backgroundColor: "$bgColorHex",
          formBackground: "$bgColorHex",
          // Лейблы — rgba(255,214,170,0.64)
          labelColor: "$inputLabelColorHex",
          // Основной текст — rgba(255,214,170,0.88)
          textColor: "$textColorHex"
        },
        borders: {
          // Инпуты: 16px, кнопка: 56px (переопределяется через CSS выше)
          radius: "16px"
        }
      },
      components: {
        paymentButton: {
          fontSize: "17px"
        },
        paymentForm: {
          labelFontSize: "15px",
          activeLabelFontSize: "13px",
          fontSize: "17px",
          backgroundColor: "$bgColorHex",
          labelColor: "$inputLabelColorHex",
          inputColor: "$inputValueColorHex"
        }
      }
  });

  function applyStyles() {
    // Фон всех контейнеров
    document.querySelectorAll('div, form, section').forEach(function(el) {
      if (!el.classList.contains('subscription-info')) {
        el.style.backgroundColor = '$bgColorHex';
      }
    });

    // Лейблы
    document.querySelectorAll('label, .cp-label, .cp-text, p, span').forEach(function(el) {
      if (!el.closest('button') && !el.closest('.subscription-info')) {
        el.style.color = '$inputLabelColorHex';
        el.style.fontFamily = 'Inter, -apple-system, sans-serif';
        el.style.letterSpacing = '-0.05em';
      }
    });

    // Значения в инпутах
    document.querySelectorAll('input, select, textarea').forEach(function(el) {
      el.style.color = '$inputValueColorHex';
      el.style.backgroundColor = '$inpBgHex';
      el.style.borderRadius = '16px';
      el.style.border = 'none';
      el.style.fontSize = '17px';
      el.style.fontFamily = 'Inter, -apple-system, sans-serif';
      el.style.letterSpacing = '-0.05em';
    });

    // Кнопка — border-radius 56px
    document.querySelectorAll('button[type="submit"], .cp-payment-button, .cp-btn-primary').forEach(function(el) {
      el.style.borderRadius = '56px';
      el.style.backgroundColor = '$buttonColorHex';
      el.style.color = '$buttonTextColorHex';
      el.style.fontWeight = '600';
      el.style.textTransform = 'uppercase';
      el.style.letterSpacing = '-0.06em';
      el.style.border = 'none';
    });

    // Заголовок
    document.querySelectorAll('h1, h2, h3, .cp-payment-title').forEach(function(el) {
      el.style.color = '$textColorHex';
      el.style.fontFamily = 'Inter, -apple-system, sans-serif';
      el.style.fontWeight = '500';
      el.style.textTransform = 'uppercase';
      el.style.letterSpacing = '-0.06em';
    });

    ${subscriptionInfoText.isNotEmpty ? '''
    if (!document.querySelector('.subscription-info')) {
      var paymentForm = document.querySelector('.cp-payment-form') ||
                        document.querySelector('.payment-form') ||
                        document.getElementById('element');
      if (paymentForm) {
        var infoDiv = document.createElement('div');
        infoDiv.className = 'subscription-info';
        infoDiv.innerHTML = '<p>$escapedSubscriptionInfo</p>';
        paymentForm.appendChild(infoDiv);
      }
    }''' : ''}
  }

  blocksApp.mount(document.getElementById("element"));

  setTimeout(applyStyles, 100);
  setTimeout(applyStyles, 500);
  setTimeout(applyStyles, 1000);

  blocksApp.on("success", function(result) {
      applyStyles();
      window.parent.postMessage({
        type: 'payment_success',
        data: {
          transaction: result,
          isTrialSubscription: ${isTrialSubscription ? 'true' : 'false'},
          trialDays: $actualTrialDays,
          amount: $initialAmount,
          regularAmount: $regularAmount,
          recurrentPeriod: $actualRecurrentPeriod,
          recurrentInterval: '$actualRecurrentInterval'
        }
      }, '*');
  });

  blocksApp.on("fail", function(result) {
      applyStyles();
      window.parent.postMessage({
        type: 'payment_fail',
        data: result
      }, '*');
  });

  blocksApp.on("error", function(error) {
      var errorMessage = 'На стороне разработчика произошла ошибка. Повторите попытку позже.';
      if (error && error.message) errorMessage = error.message;

      var errorHtml = '<div style="padding: 40px 20px; text-align: center; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center; background-color: $bgColorHex;">';
      errorHtml += '<div style="width: 80px; height: 80px; margin-bottom: 24px; border-radius: 50%; background-color: ${errorColorHex}20; display: flex; align-items: center; justify-content: center;">';
      errorHtml += '<svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">';
      errorHtml += '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z" fill="$errorColorHex"/>';
      errorHtml += '</svg></div>';
      errorHtml += '<p style="color: $textColorHex; font-family: Inter, -apple-system, sans-serif; font-size: 17px; line-height: 24px; margin: 0 0 16px 0; max-width: 300px;">' + errorMessage + '</p>';

      var subscriptionInfo = '$escapedSubscriptionInfo';
      if (subscriptionInfo && subscriptionInfo.length > 0) {
          errorHtml += '<div style="padding: 16px 20px; margin-top: 16px; background-color: $inpBgHex; border-radius: 16px; max-width: 300px;">';
          errorHtml += '<p style="font-family: Inter, -apple-system, sans-serif; font-size: 15px; line-height: 18px; letter-spacing: -0.05em; color: $inputLabelColorHex; margin: 0; text-align: center;">' + subscriptionInfo + '</p>';
          errorHtml += '</div>';
      }
      errorHtml += '</div>';

      var element = document.getElementById("element");
      if (element) element.innerHTML = errorHtml;

      window.parent.postMessage({
        type: 'payment_error',
        data: { message: errorMessage, code: error?.code || 'UNKNOWN_ERROR', error: error }
      }, '*');
  });

  } catch (error) {
      var errorMessage = 'На стороне разработчика произошла ошибка. Повторите попытку позже.';
      if (error && error.message) errorMessage = error.message;

      var errorHtml = '<div style="padding: 40px 20px; text-align: center; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center; background-color: $bgColorHex;">';
      errorHtml += '<div style="width: 80px; height: 80px; margin-bottom: 24px; border-radius: 50%; background-color: ${errorColorHex}20; display: flex; align-items: center; justify-content: center;">';
      errorHtml += '<svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">';
      errorHtml += '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z" fill="$errorColorHex"/>';
      errorHtml += '</svg></div>';
      errorHtml += '<p style="color: $textColorHex; font-family: Inter, -apple-system, sans-serif; font-size: 17px; line-height: 24px; margin: 0; max-width: 300px;">' + errorMessage + '</p>';
      errorHtml += '</div>';

      document.getElementById("element").innerHTML = errorHtml;
      window.parent.postMessage({
        type: 'payment_error',
        data: { message: errorMessage, code: 'INIT_ERROR', error: error ? error.toString() : 'Unknown error' }
      }, '*');
  }

  window.addEventListener('error', function(event) {
      if (event.error && event.error.message && !event.error.message.includes('Script error')) {
          var errorHtml = '<div style="padding: 40px 20px; text-align: center; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center; background-color: $bgColorHex;">';
          errorHtml += '<div style="width: 80px; height: 80px; margin-bottom: 24px; border-radius: 50%; background-color: ${errorColorHex}20; display: flex; align-items: center; justify-content: center;">';
          errorHtml += '<svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">';
          errorHtml += '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z" fill="$errorColorHex"/>';
          errorHtml += '</svg></div>';
          errorHtml += '<p style="color: $textColorHex; font-family: Inter, -apple-system, sans-serif; font-size: 17px; line-height: 24px; margin: 0; max-width: 300px;">На стороне разработчика произошла ошибка. Повторите попытку позже.</p>';
          errorHtml += '</div>';

          var element = document.getElementById("element");
          if (element && !element.innerHTML.includes('error')) element.innerHTML = errorHtml;

          window.parent.postMessage({
            type: 'payment_error',
            data: { message: 'На стороне разработчика произошла ошибка. Повторите попытку позже.', code: 'RUNTIME_ERROR', error: event.error ? event.error.toString() : 'Unknown error' }
          }, '*');
      }
  });
  </script>
</body>
</html>
''';
  return content;
}

DateTime dateAddMonth(
  DateTime? date,
  int period,
) {
  // date add period in months default current date
  // If date is null, use the current date
  date ??= DateTime.now();
  // Add the specified number of months to the date
  return DateTime(date.year, date.month + period, date.day, 23, 59, 59);
}

String? titleNew(String? title) {
  // Return null if title is null or empty
  if (title == null || title.isEmpty) {
    return title;
  }

  // Check if ends with "ии" -> replace with "ия"
  if (title.endsWith('ии')) {
    return title.substring(0, title.length - 2) + 'ия';
  }

  // Check if ends with "и" -> replace with "я"
  if (title.endsWith('и')) {
    return title.substring(0, title.length - 1) + 'я';
  }

  // Check if ends with "ы" -> remove it
  if (title.endsWith('ы')) {
    return title.substring(0, title.length - 1);
  }

  // If no match, return as is
  return title;
}

String priceFormat(double? price) {
  // Check if price is null, return default value
  if (price == null) {
    return '0';
  }

  // Format the number with thousand separators using period as separator
  final formatter = NumberFormat('#,###', 'en_US');
  String formattedPrice = formatter.format(price.round());

  // Replace comma with period for thousand separator
  formattedPrice = formattedPrice.replaceAll(',', '.');

  return formattedPrice;
}

String? periodFormat(int period) {
  // Handle special case for year
  if (period == 12) {
    return 'год';
  }

  // Handle special case for 1 month
  if (period == 1) {
    return 'месяц';
  }

  // For other months, determine the correct form based on the number
  int lastDigit = period % 10;
  int lastTwoDigits = period % 100;

  // Handle exceptions for 11-14 (they use "месяцев")
  if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
    return '$period месяцев';
  }

  // Determine the form based on the last digit
  if (lastDigit == 1) {
    return '$period месяц';
  } else if (lastDigit >= 2 && lastDigit <= 4) {
    return '$period месяца';
  } else {
    return '$period месяцев';
  }
}

String? imagePathToString(String? image) {
  // image path to string
  if (image == null) return null; // Check if image is null
  return image; // Convert image path to base64 string
}

bool dateGreatherThanToday(DateTime? date) {
  // true if date is greather than today than false
  if (date == null) {
    return false; // If date is null, return false
  }
  return date.isAfter(DateTime.now()); // Check if date is greater than today
}

String? monthsText(DateTime date) {
  final month = date.month;

  switch (month) {
    case 1:
      return 'ЯНВАРЕ';
    case 2:
      return 'ФЕВРАЛЕ';
    case 3:
      return 'МАРТЕ';
    case 4:
      return 'АПРЕЛЕ';
    case 5:
      return 'МАЕ';
    case 6:
      return 'ИЮНЕ';
    case 7:
      return 'ИЮЛЕ';
    case 8:
      return 'АВГУСТЕ';
    case 9:
      return 'СЕНТЯБРЕ';
    case 10:
      return 'ОКТЯБРЕ';
    case 11:
      return 'НОЯБРЕ';
    case 12:
      return 'ДЕКАБРЕ';
    default:
      return '';
  }
}

List<AudioRecord>? audioList(List<AudioRecord>? list) {
  if (list == null || list.isEmpty) return list;

  // Check if all tracks have index field filled
  final allHaveIndex = list.every((track) => track.hasIndex());

  if (allHaveIndex) {
    // Create list with original positions to preserve order for same indices
    final indexedList = list.asMap().entries.toList();

    // Sort by document index, preserving original order for tracks with same index
    indexedList.sort((a, b) {
      final indexA = a.value.index;
      final indexB = b.value.index;

      // First compare by index
      if (indexA != indexB) {
        return indexA.compareTo(indexB);
      }

      // If indices are equal, preserve original order (stable sort)
      return a.key.compareTo(b.key);
    });

    // Return sorted list of AudioRecord
    return indexedList.map((entry) => entry.value).toList();
  }

  // If not all tracks have index, return original list
  return list;
}

String urlToVideoPath(String url) {
  if (url.isEmpty) return '';

  Uri uri = Uri.parse(url);

  // Handle youtube.com URLs
  if (uri.host.contains('youtube.com')) {
    String? videoId = uri.queryParameters['v'];
    return videoId ?? url;
  }

  // Handle youtu.be URLs
  if (uri.host.contains('youtu.be')) {
    String path = uri.path;
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    int queryIndex = path.indexOf('?');
    if (queryIndex != -1) {
      path = path.substring(0, queryIndex);
    }
    return path;
  }

  // Return original URL if not YouTube
  return url;
}

bool checkVersionReview(
  String appVersion,
  String reviewVersion,
) {
  // Функция для извлечения версии и номера билда из строки
  Map<String, dynamic> extractVersionInfo(String versionString) {
    // Регулярное выражение для выделения версии и номера билда
    RegExp regex = RegExp(r'(\d+\.\d+\.\d+)[^\d]*\((\d+)\)');
    Match? match = regex.firstMatch(versionString);

    if (match != null && match.groupCount >= 2) {
      String version = match.group(1) ?? "0.0.0";
      int buildNumber = int.tryParse(match.group(2) ?? "0") ?? 0;

      // Разбиваем версию на числовые компоненты
      List<int> versionParts =
          version.split('.').map((part) => int.tryParse(part) ?? 0).toList();

      return {'versionParts': versionParts, 'buildNumber': buildNumber};
    }

    // Если формат не соответствует ожидаемому, возвращаем нулевую версию
    return {
      'versionParts': [0, 0, 0],
      'buildNumber': 0
    };
  }

  // Извлекаем информацию о версиях
  var appInfo = extractVersionInfo(appVersion);
  var reviewInfo = extractVersionInfo(reviewVersion);

  List<int> appVersionParts = appInfo['versionParts'];
  int appBuildNumber = appInfo['buildNumber'];

  List<int> reviewVersionParts = reviewInfo['versionParts'];
  int reviewBuildNumber = reviewInfo['buildNumber'];

  // Проверяем равенство всех компонентов версии (major.minor.patch)
  for (int i = 0; i < 3; i++) {
    if (appVersionParts[i] != reviewVersionParts[i]) {
      return false; // Если любой компонент отличается, возвращаем false
    }
  }

  // Если все компоненты версии одинаковые, проверяем равенство номеров билдов
  return appBuildNumber == reviewBuildNumber;
}

bool checkVersion(
  String appVersion,
  String storeVersion,
) {
  // Функция для извлечения числовой версии и номера билда из строки
  Map<String, dynamic> extractVersionInfo(String versionString) {
    // Регулярное выражение для выделения версии и номера билда
    RegExp regex = RegExp(r'(\d+\.\d+\.\d+)[^\d]*\((\d+)\)');
    Match? match = regex.firstMatch(versionString);

    if (match != null && match.groupCount >= 2) {
      String version = match.group(1) ?? "0.0.0";
      int buildNumber = int.tryParse(match.group(2) ?? "0") ?? 0;

      // Разбиваем версию на числовые компоненты
      List<int> versionParts =
          version.split('.').map((part) => int.tryParse(part) ?? 0).toList();

      return {'versionParts': versionParts, 'buildNumber': buildNumber};
    }

    // Если формат не соответствует ожидаемому, возвращаем нулевую версию
    return {
      'versionParts': [0, 0, 0],
      'buildNumber': 0
    };
  }

  // Извлекаем информацию о версиях
  var appInfo = extractVersionInfo(appVersion);
  var storeInfo = extractVersionInfo(storeVersion);

  List<int> appVersionParts = appInfo['versionParts'];
  int appBuildNumber = appInfo['buildNumber'];

  List<int> storeVersionParts = storeInfo['versionParts'];
  int storeBuildNumber = storeInfo['buildNumber'];

  // Сравниваем компоненты версии (major.minor.patch)
  for (int i = 0; i < 3; i++) {
    if (appVersionParts[i] > storeVersionParts[i]) {
      return true; // Если версия приложения выше, возвращаем true
    } else if (appVersionParts[i] < storeVersionParts[i]) {
      return false; // Если версия приложения ниже, возвращаем false
    }
  }

  // Если версии одинаковые, сравниваем номера билдов
  return appBuildNumber >= storeBuildNumber;
}

List<DateTime> monthDays(List<MonthCycleStruct>? cycles) {
  DateTime normalizeMonth(DateTime d) {
    return DateTime(d.year, d.month, 1);
  }

  List<DateTime> daysForMonth(DateTime month) {
    final lastDay = DateTime(month.year, month.month + 1, 0).day;
    return List.generate(
      lastDay,
      (i) => DateTime(month.year, month.month, i + 1),
    );
  }

  final now = DateTime.now();
  final currentMonth = DateTime(now.year, now.month, 1);
  final targetLastMonth = DateTime(now.year, now.month + 1, 1);

  final cycleMonths = (cycles ?? [])
      .where((c) => c.month != null)
      .map((c) => normalizeMonth(c.month!))
      .toSet()
      .toList()
    ..sort();

  final monthsToShow = <DateTime>[];

  if (cycleMonths.isEmpty) {
    monthsToShow.add(currentMonth);
    monthsToShow.add(targetLastMonth);
  } else {
    monthsToShow.addAll(cycleMonths);

    var lastMonth = monthsToShow.last;
    while (lastMonth.isBefore(targetLastMonth)) {
      final nextMonth = DateTime(lastMonth.year, lastMonth.month + 1, 1);
      if (!monthsToShow.contains(nextMonth)) {
        monthsToShow.add(nextMonth);
      }
      lastMonth = nextMonth;
    }
  }

  final result = <DateTime>[];
  for (final month in monthsToShow) {
    result.addAll(daysForMonth(month));
  }

  return result;
}

List<DateTime> monthDaysWithOffset(DateTime? month) {
  final target = month ?? DateTime.now();
  final firstDay = DateTime(target.year, target.month, 1);
  final lastDay = DateTime(target.year, target.month + 1, 0).day;

  // Offset from Monday (0=Mon, 6=Sun)
  final offset = firstDay.weekday - 1;

  final List<DateTime> days = [];

  // Add days from previous month as offset
  for (int i = offset; i > 0; i--) {
    days.add(firstDay.subtract(Duration(days: i)));
  }

  // Add days of current month
  for (int i = 1; i <= lastDay; i++) {
    days.add(DateTime(target.year, target.month, i));
  }

  return days;
}

String? cyclePhase(
  List<MonthCycleStruct>? monthCycle,
  DateTime? day,
) {
  if (monthCycle == null || monthCycle.isEmpty) return 'Лютеиновая';

  final target = day ?? DateTime.now();
  final dayOnly = DateTime(target.year, target.month, target.day);

  // Collect ALL menstruation and ovulation days from ALL months in the structure,
  // then pick nearest past/next markers. This way a cycle spanning across months
  // is handled correctly (e.g. ovulation this month, menstruation next month).
  final List<DateTime> allMens = [];
  final List<DateTime> allOvul = [];
  for (final c in monthCycle) {
    for (final d in c.menstruationDays) {
      allMens.add(DateTime(d.year, d.month, d.day));
    }
    for (final d in c.ovulationDays) {
      allOvul.add(DateTime(d.year, d.month, d.day));
    }
  }

  // 1. Explicit menstruation day — highest priority
  if (allMens.any((d) => d.isAtSameMomentAs(dayOnly))) {
    return 'Менструация';
  }

  // 2. Explicit ovulation day
  if (allOvul.any((d) => d.isAtSameMomentAs(dayOnly))) {
    return 'Овуляция';
  }

  // Helpers for finding nearest markers
  DateTime? nearestBefore(List<DateTime> days, DateTime target) {
    DateTime? result;
    for (final d in days) {
      if (d.isBefore(target)) {
        if (result == null || d.isAfter(result)) result = d;
      }
    }
    return result;
  }

  DateTime? nearestAfter(List<DateTime> days, DateTime target) {
    DateTime? result;
    for (final d in days) {
      if (d.isAfter(target)) {
        if (result == null || d.isBefore(result)) result = d;
      }
    }
    return result;
  }

  final DateTime? prevMens = nearestBefore(allMens, dayOnly);
  final DateTime? nextMens = nearestAfter(allMens, dayOnly);
  final DateTime? prevOvul = nearestBefore(allOvul, dayOnly);
  final DateTime? nextOvul = nearestAfter(allOvul, dayOnly);

  // Phase logic based on the most recent and next events around dayOnly:
  //
  // Timeline of a cycle:
  //   [Menstruation] → [Follicular] → [Ovulation] → [Luteal] → [Menstruation...]
  //
  // Key rule: if the most recent event was ovulation → Luteal;
  //           if the most recent event was menstruation (and next is ovulation) → Follicular;
  //           if the most recent event was menstruation (and no ovulation ahead) → Follicular (best guess);
  //           if no previous events at all → infer from what's ahead.

  // 3. If we have a previous ovulation AND it's more recent than the previous menstruation → Luteal
  if (prevOvul != null && (prevMens == null || prevOvul.isAfter(prevMens))) {
    return 'Лютеиновая';
  }

  // 4. If we have a previous menstruation → we're past menstruation in some cycle
  if (prevMens != null) {
    // If ovulation is ahead before the next menstruation → Follicular
    if (nextOvul != null && (nextMens == null || nextOvul.isBefore(nextMens))) {
      return 'Фолликулярная';
    }
    // No ovulation data ahead — default to Follicular (post-menstruation, pre-ovulation guess)
    return 'Фолликулярная';
  }

  // 5. No previous events — we're before the very first tracked cycle
  // If next event is menstruation → we're likely in Luteal phase of an untracked previous cycle
  // If next event is ovulation → we're in Follicular phase
  if (nextOvul != null && (nextMens == null || nextOvul.isBefore(nextMens))) {
    return 'Фолликулярная';
  }

  // Default: Luteal (tail of an untracked previous cycle)
  return 'Лютеиновая';
}

List<MonthCycleStruct> calendarMonths(
  List<MonthCycleStruct>? monthCycle,
  DateTime? startDate,
  int? cycleDuration,
  int? menstruationDuration,
) {
  DateTime normalizeDate(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  DateTime normalizeMonth(DateTime d) {
    return DateTime(d.year, d.month, 1);
  }

  int effectiveCycleDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 28;
  }

  int effectiveMensDuration(int? paramValue, int? structValue) {
    if (paramValue != null && paramValue > 0) return paramValue;
    if (structValue != null && structValue > 0) return structValue;
    return 5;
  }

  DateTime? effectiveStartDate(DateTime? paramValue, List<DateTime> mensDays) {
    if (paramValue != null) return normalizeDate(paramValue);
    if (mensDays.isEmpty) return null;
    final normalized = mensDays.map(normalizeDate).toList()..sort();
    return normalized.first;
  }

  List<DateTime> buildMenstruationDays(DateTime start, int mensDur) {
    return List.generate(
      mensDur,
      (i) => normalizeDate(start.add(Duration(days: i))),
    )..sort();
  }

  List<DateTime> buildOvulationDays(DateTime start, int cycleDur) {
    final ovulationOffset = (cycleDur - 14) - 1;
    final central = start.add(Duration(days: ovulationOffset));
    return [
      for (int i = -4; i <= 2; i++)
        normalizeDate(central.add(Duration(days: i))),
    ]..sort();
  }

  List<DateTime> daysInMonth(List<DateTime> source, DateTime monthValue) {
    final monthStart = DateTime(monthValue.year, monthValue.month, 1);
    final monthEnd = DateTime(monthValue.year, monthValue.month + 1, 1);
    return source
        .map(normalizeDate)
        .where((d) => !d.isBefore(monthStart) && d.isBefore(monthEnd))
        .toList()
      ..sort();
  }

  List<DateTime> removeCollisions(
    List<DateTime> menstruationDays,
    List<DateTime> ovulationDays,
  ) {
    final ovulSet = ovulationDays.map(normalizeDate).toSet();
    return menstruationDays
        .map(normalizeDate)
        .where((d) => !ovulSet.contains(d))
        .toList()
      ..sort();
  }

  final result = monthCycle != null
      ? List<MonthCycleStruct>.from(monthCycle)
      : <MonthCycleStruct>[];

  result.sort(
    (a, b) => (a.month ?? DateTime(0)).compareTo(b.month ?? DateTime(0)),
  );

  final now = DateTime.now();
  final currentMonth = DateTime(now.year, now.month, 1);
  final targetLastMonth = DateTime(now.year, now.month + 1, 1);

  MonthCycleStruct? lastWithData() {
    for (int i = result.length - 1; i >= 0; i--) {
      if (result[i].menstruationDays.isNotEmpty) return result[i];
    }
    return result.isNotEmpty ? result.last : null;
  }

  final ref = lastWithData();

  final effectiveCycle = effectiveCycleDuration(
    cycleDuration,
    ref?.cycleDuration,
  );
  final effectiveMens = effectiveMensDuration(
    menstruationDuration,
    ref?.menstruationDuration,
  );
  final effectiveStart = startDate != null
      ? normalizeDate(startDate)
      : effectiveStartDate(null, ref?.menstruationDays ?? []);

  final existingMonths = result
      .where((c) => c.month != null)
      .map((c) => normalizeMonth(c.month!))
      .toSet()
      .toList()
    ..sort();

  bool hasMonth(DateTime monthValue) {
    return existingMonths.any(
      (m) => m.year == monthValue.year && m.month == monthValue.month,
    );
  }

  MonthCycleStruct buildMonth(DateTime monthValue) {
    if (effectiveStart == null) {
      return MonthCycleStruct(
        month: monthValue,
        menstruationDays: [],
        ovulationDays: [],
        menstruationDuration: effectiveMens,
        cycleDuration: effectiveCycle,
      );
    }

    final fullMens = <DateTime>[];
    final fullOvul = <DateTime>[];

    var cycleStart = effectiveStart;

    while (cycleStart.isAfter(monthValue)) {
      cycleStart = cycleStart.subtract(Duration(days: effectiveCycle));
    }

    final monthEnd = DateTime(monthValue.year, monthValue.month + 1, 1);
    while (cycleStart.isBefore(monthEnd)) {
      fullMens.addAll(buildMenstruationDays(cycleStart, effectiveMens));
      fullOvul.addAll(buildOvulationDays(cycleStart, effectiveCycle));
      cycleStart = cycleStart.add(Duration(days: effectiveCycle));
    }

    final ovulInMonth = daysInMonth(fullOvul, monthValue);
    final mensInMonth =
        removeCollisions(daysInMonth(fullMens, monthValue), ovulInMonth);

    return MonthCycleStruct(
      month: monthValue,
      menstruationDays: mensInMonth,
      ovulationDays: ovulInMonth,
      menstruationDuration: effectiveMens,
      cycleDuration: effectiveCycle,
    );
  }

  if (existingMonths.isEmpty) {
    result.add(buildMonth(currentMonth));
    result.add(buildMonth(targetLastMonth));
  } else {
    var lastMonth = existingMonths.last;
    while (lastMonth.isBefore(targetLastMonth)) {
      final nextMonth = DateTime(lastMonth.year, lastMonth.month + 1, 1);
      if (!hasMonth(nextMonth)) {
        result.add(buildMonth(nextMonth));
        existingMonths.add(nextMonth);
      }
      lastMonth = nextMonth;
    }
  }

  result.sort(
    (a, b) => (a.month ?? DateTime(0)).compareTo(b.month ?? DateTime(0)),
  );
  return result;
}

String mensDayText(List<MonthCycleStruct>? monthCycle) {
  if (monthCycle == null || monthCycle.isEmpty) return 'Не указано';

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  // Collect all menstruation days across all cycles
  final List<DateTime> allMensDays = [];
  for (final cycle in monthCycle) {
    for (final d in cycle.menstruationDays) {
      allMensDays.add(DateTime(d.year, d.month, d.day));
    }
  }

  if (allMensDays.isEmpty) return 'Не указано';

  // Check if today is a menstruation day
  if (allMensDays.contains(today)) return 'Идут';

  // Find next menstruation start (first day of next group)
  allMensDays.sort();

  // Find next day after today
  final upcoming = allMensDays.where((d) => d.isAfter(today)).toList();
  if (upcoming.isEmpty) return 'Не указано';

  // Find first day of next period (not consecutive with previous)
  DateTime? nextStart;
  for (int i = 0; i < upcoming.length; i++) {
    final d = upcoming[i];
    // It's a start if previous day is not in the list
    final prev = d.subtract(const Duration(days: 1));
    if (!allMensDays.contains(prev)) {
      nextStart = d;
      break;
    }
  }

  if (nextStart == null) return 'Не указано';

  final diff = nextStart.difference(today).inDays;
  if (diff == 0) return 'Идут';
  return 'через $diff д.';
}

String ovulationDayText(List<MonthCycleStruct>? monthCycle) {
  if (monthCycle == null || monthCycle.isEmpty) return 'Не указано';

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  // Collect all ovulation days across all cycles
  final List<DateTime> allOvulDays = [];
  for (final cycle in monthCycle) {
    for (final d in cycle.ovulationDays) {
      allOvulDays.add(DateTime(d.year, d.month, d.day));
    }
  }

  if (allOvulDays.isEmpty) return 'Не указано';

  allOvulDays.sort();

  // Check if today is an ovulation day
  if (allOvulDays.contains(today)) return 'Идёт';

  // Find next ovulation group (consecutive days starting after today)
  final upcoming = allOvulDays.where((d) => d.isAfter(today)).toList();
  if (upcoming.isEmpty) return 'Не указано';

  // Find start of next ovulation group
  DateTime? groupStart;
  for (final d in upcoming) {
    final prev = d.subtract(const Duration(days: 1));
    if (!allOvulDays.contains(prev)) {
      groupStart = d;
      break;
    }
  }

  if (groupStart == null) return 'Не указано';

  // Find end of that group (last consecutive day)
  DateTime groupEnd = groupStart;
  while (allOvulDays.contains(groupEnd.add(const Duration(days: 1)))) {
    groupEnd = groupEnd.add(const Duration(days: 1));
  }

  // Format as "10.12-12.12"
  final startStr =
      '${groupStart.day}.${groupStart.month.toString().padLeft(2, '0')}';
  final endStr = '${groupEnd.day}.${groupEnd.month.toString().padLeft(2, '0')}';

  if (groupStart == groupEnd) return startStr;
  return '$startStr-$endStr';
}

AudioRecord audioFileRandom(List<AudioRecord> audioList) {
  // random document
  final randomIndex = math.Random().nextInt(audioList.length);
  return audioList[randomIndex];
}

String monthTitle(DateTime? month) {
  final d = month ?? DateTime.now();
  const months = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];
  return '${months[d.month - 1]} ${d.year}';
}

String monthTitlePremium(DateTime? month) {
  final d = month ?? DateTime.now();
  const months = [
    'январе',
    'феврале',
    'марте',
    'апреле',
    'мае',
    'июне',
    'июле',
    'августе',
    'сентябре',
    'октябре',
    'ноябре',
    'декабре',
  ];
  return 'в ${months[d.month - 1]}';
}

List<AudioRecord> emptyAudioList() {
  // empty document list
  return [];
}

String phaseBannerText(String? phase) {
  switch (phase) {
    case 'Менструация':
      return 'Сегодня ты можешь чувствовать меньше энергии и потребность в отдыхе. Узнай больше из нашего обзора.';
    case 'Фолликулярная':
      return 'Сегодня может быть легче собраться и сосредоточиться. Узнай больше из нашего обзора.';
    case 'Овуляция':
      return 'Сегодня ты можешь чувствовать подъем энергии и уверенности. Узнай больше из нашего обзора.';
    case 'Лютеиновая':
      return 'Сегодня ты можешь быть более чувствительной. Узнай больше из нашего обзора.';
    default:
      return 'Узнай больше из нашего обзора.';
  }
}

List<String>? audioCategories(List<String>? categories) {
  final result = <String>['Новое', 'Избранное'];
  final seen = <String>{'Новое', 'Избранное'};

  if (categories != null) {
    for (final category in categories) {
      final value = category.trim();
      if (value.isNotEmpty && !seen.contains(value)) {
        seen.add(value);
        result.add(value);
      }
    }
  }

  return result;
}
