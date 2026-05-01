import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD8eK213F4BpEH0rPe1uXpTn1RNXaDnfN8",
            authDomain: "woman-f4872.firebaseapp.com",
            projectId: "woman-f4872",
            storageBucket: "woman-f4872.firebasestorage.app",
            messagingSenderId: "855281721515",
            appId: "1:855281721515:web:c934287b81998f8c4217ee",
            measurementId: "G-8V2JY8TJEV"));
  } else {
    await Firebase.initializeApp();
  }
}
