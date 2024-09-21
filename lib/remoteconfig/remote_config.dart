import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> setupRemoteConfig() async {
  await Firebase.initializeApp();

  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: Duration(seconds: 10),
    minimumFetchInterval: Duration(hours: 1),
  ));

  await remoteConfig.fetchAndActivate();
}

bool shouldShowDiscountedPrice(FirebaseRemoteConfig remoteConfig) {
  return remoteConfig.getBool('showDiscountedPrice');
}
