import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'this app only supports Android and iOS.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBTJj-YTA1O4_UmOkVpRNS4IAlXHSeHCI8",
    appId: '1:296260096493:android:a9d066551b47b4d92797e4',
    messagingSenderId: '296260096493', // Your exact project number!
    projectId: 'local-services-app-90c27',
    storageBucket: 'local-services-app-90c27.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: '296260096493',
    projectId: 'local-services-app-90c27',
    storageBucket: 'local-services-app-90c27.appspot.com',
    iosBundleId: 'com.example.localServices', // Change if your bundle ID is different
  );
}