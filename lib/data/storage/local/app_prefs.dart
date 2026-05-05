// ignore_for_file: unused_field

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';
import '../../../features/auth/data/model/user_model.dart';

@singleton
class AppPreferences {
  final String _isDarkMode = 'isDarkMode';
  final String _lang = 'lang';
  final String _isLogin = 'isLogin';
  final String _userToken = 'userToken';
  final String _userData = 'userData';
  final String _isLanguageSelected = 'isLanguageSelected';
  final String _firebaseToken = 'firebaseToken';
  final String _userType = 'userType';
  final String _appName = '_AppName';
  final String _font = 'font';
  static const String _ownerInfo = 'ownerInfo';
  final String _userInfo = "_userInfo";
  final String _dateMethod = 'dateMethod';

  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<bool> _putData(String key, dynamic value) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    return await _sharedPreferences.setBool(key, value);
  }

  // static Future<void> putOwnerInfo(QwnerModel ownerInfo) async {
  //   var box = await Hive.openBox<QwnerModel>(_ownerInfo);
  //   await box.put(_ownerInfo, ownerInfo);
  // }

  // static Future<QwnerModel?> getOwnerInfo() async {
  //   var box = await Hive.openBox<QwnerModel>(_ownerInfo);
  //   return box.get(_ownerInfo);
  // }

  // static Future<void> deleteOwnerInfo() async {
  //   var box = await Hive.openBox<QwnerModel>(_ownerInfo);
  //   await box.delete(_ownerInfo);
  // }

  dynamic _getData(String key, dynamic def) {
    var value = _sharedPreferences.get(key);
    return value ?? def;
  }

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  String get firebaseToken => _getData(_firebaseToken, '');
  set firebaseToken(data) => _putData(_firebaseToken, data);

  String get lang => _getData(_lang, Constants.defaultLanguage);

  set lang(String value) {
    _putData(_lang, value);
  }

  set dateMethod(String value) {
    _putData(_dateMethod, value);
  }

  String get dateMethod => _getData(_dateMethod, null);

  String get font => _getData(_font, Constants.enFont);

  set font(String value) {
    _putData(_font, value);
  }

  bool get isDarkMode => _getData(_isDarkMode, false);

  set isDarkMode(bool value) {
    _putData(_isDarkMode, value);
  }

  bool get isLanguageSelected => _getData(_isLanguageSelected, false);

  set isLanguageSelected(bool value) {
    _putData(_isLanguageSelected, value);
  }

  bool get isUserLogin => _getData(_userToken, "").isNotEmpty;

  String get userToken => _getData(_userToken, "");

  set userToken(String value) {
    _putData(_userToken, value);
  }

  String get userType => _getData(_userType, "");

  String get appName => _getData(_appName, "");

  set appName(String value) {
    _putData(_appName, value);
  }

  void removeAppName() {
    _sharedPreferences.remove(_appName);
  }

  set userType(String value) {
    _putData(_userType, value);
  }

  void changeLanguage(String lang) {
    _putData(_lang, lang);
    _putData(_isLanguageSelected, true);
  }

  UserModel? get loadEmployeeData {
    var jsonEncode = _getData(_userInfo, null);
    UserModel? userModel;
    if (jsonEncode != null) {
      Map<String, dynamic> map = json.decode(jsonEncode);
      userModel = UserModel.fromJson(map);
    }
    return userModel;
  }

  Future<void> userData(UserModel? user) async {
    await _putData(_userInfo, jsonEncode(user));
  } // user data

  Future<void> removeUserData() async {
    await _sharedPreferences.remove(_userInfo);
  }

  Future<void> login(LoginModel user) async {
    userToken = user.token!;
    await userData(user.user);
  }

  Future<void> logOut() async {
    userToken = "";
    await removeUserData();
  }
}
