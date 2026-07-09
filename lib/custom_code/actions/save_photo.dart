// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:gal/gal.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

Future<bool> savePhoto(
  BuildContext context,
  String imageUrl,
  String message,
) async {
  try {
    if (imageUrl.isEmpty) return false;

    // Permissions
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final status = await Permission.photos.request();
      if (status.isDenied) return false;
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      final status = await Permission.storage.request();
      if (status.isDenied) return false;
    }

    // Download image
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    final response = await dio.get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    if (response.statusCode != 200) return false;

    // Decode image
    final codec = await ui.instantiateImageCodec(
      Uint8List.fromList(response.data),
    );
    final frame = await codec.getNextFrame();
    final srcImage = frame.image;

    final imgW = srcImage.width.toDouble();
    final imgH = srcImage.height.toDouble();
    const padding = 20.0;

    // Setup canvas
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, imgW, imgH));

    // Draw background image
    canvas.drawImage(srcImage, Offset.zero, Paint());

    // Semi-transparent overlay so text is always legible (optional — remove if not wanted)
    // canvas.drawRect(
    //   Rect.fromLTWH(0, 0, imgW, imgH),
    //   Paint()..color = Colors.black.withOpacity(0.15),
    // );

    // Text style matching the UI
    final textPainter = TextPainter(
      text: TextSpan(
        text: message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 48.0,
          fontFamily: 'Inter Tight',
          height: 1.25,
          letterSpacing: 0.0,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
      maxLines: 10,
    );

    final maxWidth = imgW - padding * 2;
    textPainter.layout(maxWidth: maxWidth);

    // Center text on image
    final textX = (imgW - textPainter.width) / 2;
    final textY = (imgH - textPainter.height) / 2;
    textPainter.paint(canvas, Offset(textX, textY));

    // Rasterise
    final picture = recorder.endRecording();
    final composited = await picture.toImage(imgW.toInt(), imgH.toInt());
    final byteData =
        await composited.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return false;

    await Gal.putImageBytes(byteData.buffer.asUint8List());
    return true;
  } catch (e) {
    print('Error saving image: $e');
    return false;
  }
}
