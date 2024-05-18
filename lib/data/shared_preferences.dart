import 'package:shared_preferences/shared_preferences.dart';

enum PreferencesKey {
  token(''),
  firstTimeLaunch(true),
  locale('en');

  final dynamic defaultValue;
  const PreferencesKey(this.defaultValue);
}

class Prefs {
  static late SharedPreferences pref;

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  static T get<T>(PreferencesKey preferencesKey) {
    return pref.get(preferencesKey.name) ?? preferencesKey.defaultValue;
  }

  static Future<bool> set<T>(PreferencesKey preferencesKey, T value) async {
    value ??= preferencesKey.defaultValue;
    switch (value.runtimeType) {
      case const (String):
        return await pref.setString(preferencesKey.name, value as String);
      case const (List<String>):
        return await pref.setStringList(
            preferencesKey.name, value as List<String>);
      case const (double):
        return await pref.setDouble(preferencesKey.name, value as double);
      case const (bool):
        return await pref.setBool(preferencesKey.name, value as bool);
      case const (int):
        return await pref.setInt(preferencesKey.name, value as int);
      default:
        return false;
    }
  }

  static Future deleteAll({
    List<PreferencesKey> keyToKeep = const [
      PreferencesKey.locale,
      PreferencesKey.firstTimeLaunch,
    ],
  }) async {
    final valueToKeep = keyToKeep.map((e) => get(e)).toList();
    await pref.clear();
    for (var i = 0; i < keyToKeep.length; i++) {
      await set(keyToKeep[i], valueToKeep[i]);
    }
  }
}
