import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

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
