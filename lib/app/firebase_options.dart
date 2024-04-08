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
final class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => macos,
      TargetPlatform.windows => throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.linux => throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      _ => throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        ),
    };
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD2LxZiL2ZSWSmnSw0XYrVxkZqQdu4CPCM',
    appId: '1:328206024183:web:d119485424430b235ec2f2',
    messagingSenderId: '328206024183',
    projectId: 'todo-list-provider-bdbd3',
    authDomain: 'todo-list-provider-bdbd3.firebaseapp.com',
    storageBucket: 'todo-list-provider-bdbd3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuVR5wmpxbef9OwybSc0zEC8syuPFYO2o',
    appId: '1:328206024183:android:601ae62899b7d5265ec2f2',
    messagingSenderId: '328206024183',
    projectId: 'todo-list-provider-bdbd3',
    storageBucket: 'todo-list-provider-bdbd3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzPnQ7W9l0uy0M-XEENXVAp2GQGOMPMt8',
    appId: '1:328206024183:ios:d50c06ffb961a3815ec2f2',
    messagingSenderId: '328206024183',
    projectId: 'todo-list-provider-bdbd3',
    storageBucket: 'todo-list-provider-bdbd3.appspot.com',
    androidClientId:
        '328206024183-iunuirjq1adbutjg1s1r4hicgb5udg4i.apps.googleusercontent.com',
    iosClientId:
        '328206024183-asj93s95p5p3fl5rkhqddousdghqqoma.apps.googleusercontent.com',
    iosBundleId: 'br.com.roveri.todoListProvider',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzPnQ7W9l0uy0M-XEENXVAp2GQGOMPMt8',
    appId: '1:328206024183:ios:d50c06ffb961a3815ec2f2',
    messagingSenderId: '328206024183',
    projectId: 'todo-list-provider-bdbd3',
    storageBucket: 'todo-list-provider-bdbd3.appspot.com',
    androidClientId:
        '328206024183-iunuirjq1adbutjg1s1r4hicgb5udg4i.apps.googleusercontent.com',
    iosClientId:
        '328206024183-asj93s95p5p3fl5rkhqddousdghqqoma.apps.googleusercontent.com',
    iosBundleId: 'br.com.roveri.todoListProvider',
  );
}
