import 'package:shared_preferences/shared_preferences.dart';

class PrefenceHelper {
  final Future<SharedPreferences> sharedPreference;
  PrefenceHelper(this.sharedPreference);
  static const TOKEN = 'TOKEN';
  static const EMAIL = 'EMAIL';
  static const ID = "IDUSER";
  static const TITLE = "TITLE";
  static const PHONE = "PHONE";
  static const STORE = "STORE";
  static const NAMEAPP = "NAMEAPP";
  static const NAMATOKO = "NAMATOKO";
  static const VERSION = "VERSION";
  static const DESCRIPTION = "DESCRIPTION";

  Future<String> get token async {
    final prefs = await sharedPreference;
    return prefs.getString(TOKEN) ?? "";
  }

  void setToken(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(TOKEN, value);
  }

  Future<String> get namaToko async {
    final prefs = await sharedPreference;
    return prefs.getString(NAMATOKO) ?? "";
  }

  void setNamaToko(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(NAMATOKO, value);
  }

  Future<String> get phone async {
    final prefs = await sharedPreference;
    return prefs.getString(PHONE) ?? "";
  }

  void setPhone(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(PHONE, value);
  }

  Future<String> get store async {
    final prefs = await sharedPreference;
    return prefs.getString(STORE) ?? "";
  }

  void setStore(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(STORE, value);
  }

  Future<String> get title async {
    final prefs = await sharedPreference;
    return prefs.getString(TITLE) ?? "";
  }

  void setTitle(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(TITLE, value);
  }

  Future<String> get description async {
    final prefs = await sharedPreference;
    return prefs.getString(DESCRIPTION) ?? "";
  }

  void setDesc(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(DESCRIPTION, value);
  }

  Future<String> get version async {
    final prefs = await sharedPreference;
    return prefs.getString(VERSION) ?? "";
  }

  void setVersion(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(VERSION, value);
  }

  Future<String> get nameApp async {
    final prefs = await sharedPreference;
    return prefs.getString(NAMEAPP) ?? "";
  }

  void setNameApp(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(NAMEAPP, value);
  }

  Future<String> get email async {
    final prefs = await sharedPreference;
    return prefs.getString(EMAIL) ?? "";
  }

  void setEmail(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(EMAIL, value);
  }

  Future<int> get id async {
    final prefs = await sharedPreference;
    return prefs.getInt(ID) ?? 0;
  }

  void setId(int value) async {
    final prefs = await sharedPreference;
    prefs.setInt(ID, value);
  }
}
