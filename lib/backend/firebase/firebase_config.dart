import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDAG4sgdRT062laZbERLMfu0vJ6nERWIag",
            authDomain: "tetote-37603.firebaseapp.com",
            projectId: "tetote-37603",
            storageBucket: "tetote-37603.appspot.com",
            messagingSenderId: "324845833473",
            appId: "1:324845833473:web:8db9856db20dd30d225f00",
            measurementId: "G-433HN6WH9N"));
  } else {
    await Firebase.initializeApp();
  }
}
