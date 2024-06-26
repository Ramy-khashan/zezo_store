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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAxzwebvAijsF8HCq-QE_pIRZlbPa1RjMw',
    appId: '1:935517971692:android:9ed67e5de4b2b53220f1c9',
    messagingSenderId: '935517971692',
    projectId: 'zezo-store-32084',
    storageBucket: 'zezo-store-32084.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBJOU7YcAUMe1oitumoqYetc_aTIFf5MU',
    appId: '1:935517971692:ios:24ca8edd63df642220f1c9',
    messagingSenderId: '935517971692',
    projectId: 'zezo-store-32084',
    storageBucket: 'zezo-store-32084.appspot.com',
    androidClientId: '935517971692-b9hgtpt30pijgtj6dt51q998ka2si4g0.apps.googleusercontent.com',
    iosClientId: '935517971692-2mq53maht8gineomhbo76p1kp5rr7u0j.apps.googleusercontent.com',
    iosBundleId: 'com.zezostore.zezo',
  );
}