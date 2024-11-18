// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCO9GMYYEVVCmnnK8GRFUElRDW6mjrkr3k',
    appId: '1:825901991201:web:cec79c0c0237c144272a60',
    messagingSenderId: '825901991201',
    projectId: 'guff-gaff-7a4a3',
    authDomain: 'guff-gaff-7a4a3.firebaseapp.com',
    storageBucket: 'guff-gaff-7a4a3.appspot.com',
    measurementId: 'G-H2ZS09LJCX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRj9Suu9K2NtPNJF6vqwLz9_ub8ttk7P0',
    appId: '1:825901991201:android:5d7b2f62e92c58b5272a60',
    messagingSenderId: '825901991201',
    projectId: 'guff-gaff-7a4a3',
    storageBucket: 'guff-gaff-7a4a3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzX6siJIXN7af-VTlmcmnPkVwyTIiQZPg',
    appId: '1:825901991201:ios:ebdf10c620dc54cd272a60',
    messagingSenderId: '825901991201',
    projectId: 'guff-gaff-7a4a3',
    storageBucket: 'guff-gaff-7a4a3.appspot.com',
    iosBundleId: 'com.example.guffgaff',
  );

}