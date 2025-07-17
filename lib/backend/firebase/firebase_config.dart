import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDC0uWcj8t7E5hEM5WPyQmELXGrzmRGpbI",
            authDomain: "digital-station-918b8.firebaseapp.com",
            projectId: "digital-station-918b8",
            storageBucket: "digital-station-918b8.firebasestorage.app",
            messagingSenderId: "622698835869",
            appId: "1:622698835869:web:50373caff0e4452dadc974",
            measurementId: "G-8QLCXZ54R9"));
  } else {
    await Firebase.initializeApp();
  }
}
