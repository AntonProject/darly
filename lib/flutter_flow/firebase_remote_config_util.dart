import 'package:firebase_remote_config/firebase_remote_config.dart';

Future initializeFirebaseRemoteConfig() async {
  try {
    await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await FirebaseRemoteConfig.instance.setDefaults(const {
      'cloudKey': '',
      'cloudTestKey': '',
      'secretKey': '',
      'secretTestKey': '',
      'website': 'https://appfyl.com/ru',
      'terms': 'https://appfyl.com/ru',
      'userAgreement': 'https://appfyl.com/ru',
      'supportTg': 'https://t.me',
      'emailSupport': '',
      'license_info': '',
      'appleReviewVersion': '',
      'googleReviewVersion': '',
      'appleVersion': '',
      'googleVersion': '',
      'showMetaCards': false,
      'taxationSystem': 1,
      'vat': '',
      'accessToken': '',
      'teamUrl': 't.me',
    });
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  } catch (error) {
    print(error);
  }
}

String getRemoteConfigString(String key) =>
    FirebaseRemoteConfig.instance.getString(key);

bool getRemoteConfigBool(String key) =>
    FirebaseRemoteConfig.instance.getBool(key);

int getRemoteConfigInt(String key) => FirebaseRemoteConfig.instance.getInt(key);

double getRemoteConfigDouble(String key) =>
    FirebaseRemoteConfig.instance.getDouble(key);
