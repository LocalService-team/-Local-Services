import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'iOS is not configured yet. Please add real Firebase iOS credentials.',
        );
      default:
        throw UnsupportedError('This platform is not supported.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBTJj-YTA1O4_UmOkVpRNS4IAlXHSeHCI8',
    appId: '1:296260096493:web:a9d066551b47b4d92797e4',
    messagingSenderId: '296260096493',
    projectId: 'local-services-app-90c27',
    authDomain: '://firebaseapp.com',
    storageBucket: '://appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTJj-YTA1O4_UmOkVpRNS4IAlXHSeHCI8',
    appId: '1:296260096493:android:a9d066551b47b4d92797e4',
    messagingSenderId: '296260096493',
    projectId: 'local-services-app-90c27',
    storageBucket: '://appspot.com',
  );
}
