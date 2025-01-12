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
    apiKey: 'AIzaSyCXlT497myG7t04Sxq6Jp7hD-Pkl5g4HVU',
    appId: '1:854666107515:web:61dc3614e1af6ad03fa0de',
    messagingSenderId: '854666107515',
    projectId: 'cw8app',
    authDomain: 'cw8app.firebaseapp.com',
    storageBucket: 'cw8app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoc9l0A0jrPPp8kAEG7WThlbL6pOcp038',
    appId: '1:854666107515:android:313297e895f9656c3fa0de',
    messagingSenderId: '854666107515',
    projectId: 'cw8app',
    storageBucket: 'cw8app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3V9OBb2BxrvN07iVgA29CIpc-rI43XOU',
    appId: '1:854666107515:ios:c7f20f40001a902f3fa0de',
    messagingSenderId: '854666107515',
    projectId: 'cw8app',
    storageBucket: 'cw8app.firebasestorage.app',
    iosBundleId: 'com.example.cw8',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3V9OBb2BxrvN07iVgA29CIpc-rI43XOU',
    appId: '1:854666107515:ios:c7f20f40001a902f3fa0de',
    messagingSenderId: '854666107515',
    projectId: 'cw8app',
    storageBucket: 'cw8app.firebasestorage.app',
    iosBundleId: 'com.example.cw8',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCXlT497myG7t04Sxq6Jp7hD-Pkl5g4HVU',
    appId: '1:854666107515:web:72c07147a12c45fc3fa0de',
    messagingSenderId: '854666107515',
    projectId: 'cw8app',
    authDomain: 'cw8app.firebaseapp.com',
    storageBucket: 'cw8app.firebasestorage.app',
  );
}
