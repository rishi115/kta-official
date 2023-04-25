// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAa8fYuFpkr9sVxc49YP_mDbHA-wIJJWFI',
    appId: '1:613026692136:web:1f3e68d9eecab74bf0091d',
    messagingSenderId: '613026692136',
    projectId: 'kta-official',
    authDomain: 'kta-official.firebaseapp.com',
    storageBucket: 'kta-official.appspot.com',
    measurementId: 'G-HLH6C037M9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKQPl5nHNhNv19YDfRUqQlHfSxUSx18GM',
    appId: '1:613026692136:android:e96fd0d392ef6db8f0091d',
    messagingSenderId: '613026692136',
    projectId: 'kta-official',
    storageBucket: 'kta-official.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLOa4NWfzfQUFCHxFJINb3twuJTt7I24s',
    appId: '1:613026692136:ios:92b4f1aab1beec94f0091d',
    messagingSenderId: '613026692136',
    projectId: 'kta-official',
    storageBucket: 'kta-official.appspot.com',
    iosClientId: '613026692136-cl1gd4qg25rjc7cptjvuoaq3d74cdfju.apps.googleusercontent.com',
    iosBundleId: 'com.example.ktaOfficial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBLOa4NWfzfQUFCHxFJINb3twuJTt7I24s',
    appId: '1:613026692136:ios:92b4f1aab1beec94f0091d',
    messagingSenderId: '613026692136',
    projectId: 'kta-official',
    storageBucket: 'kta-official.appspot.com',
    iosClientId: '613026692136-cl1gd4qg25rjc7cptjvuoaq3d74cdfju.apps.googleusercontent.com',
    iosBundleId: 'com.example.ktaOfficial',
  );
}