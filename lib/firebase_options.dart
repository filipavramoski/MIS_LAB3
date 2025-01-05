
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
        return windows;
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
    apiKey: 'AIzaSyA9J3DqxzJDFW7HYZL4Eu-OX4rB1NSYDQ0',
    appId: '1:590650296443:web:ecfcc98943768d8e273ade',
    messagingSenderId: '590650296443',
    projectId: 'mislab3firebase',
    authDomain: 'mislab3firebase.firebaseapp.com',
    storageBucket: 'mislab3firebase.firebasestorage.app',
    measurementId: 'G-JVGW731L5J',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbs4B0DZp2Q5CcnI2YrEdNlFhi1CJY2M8',
    appId: '1:590650296443:ios:2b1b7d698792bd12273ade',
    messagingSenderId: '590650296443',
    projectId: 'mislab3firebase',
    storageBucket: 'mislab3firebase.firebasestorage.app',
    iosBundleId: 'com.example.lab2211063',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbs4B0DZp2Q5CcnI2YrEdNlFhi1CJY2M8',
    appId: '1:590650296443:ios:2b1b7d698792bd12273ade',
    messagingSenderId: '590650296443',
    projectId: 'mislab3firebase',
    storageBucket: 'mislab3firebase.firebasestorage.app',
    iosBundleId: 'com.example.lab2211063',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9J3DqxzJDFW7HYZL4Eu-OX4rB1NSYDQ0',
    appId: '1:590650296443:web:3340676ba5370882273ade',
    messagingSenderId: '590650296443',
    projectId: 'mislab3firebase',
    authDomain: 'mislab3firebase.firebaseapp.com',
    storageBucket: 'mislab3firebase.firebasestorage.app',
    measurementId: 'G-8MJVP70Y9S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxPfpVbO3Oj7TUmhNITNkzcPNdVsKGL3A',
    appId: '1:590650296443:android:8110a6dcd19922ee273ade',
    messagingSenderId: '590650296443',
    projectId: 'mislab3firebase',
    storageBucket: 'mislab3firebase.firebasestorage.app',
  );

}