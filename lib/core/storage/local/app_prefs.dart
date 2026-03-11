// ignore_for_file: unused_field

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

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
  final String _employeeInfo = "_employeeInfo";
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

  //user data
  // QwnerModel? get userData {
  //   String data = _getData(_userData, "");
  //   if (data.isEmpty) return null;
  //   return QwnerModel.fromJson(jsonDecode(_getData(_userData, null)));
  // }

  // QwnerModel? get loadUserData {
  //   var jsonEncode = _getData("userData", null);
  //   QwnerModel? userModel;
  //   if (jsonEncode != null) {
  //     Map<String, dynamic> map = json.decode(jsonEncode);
  //     userModel = QwnerModel.fromJson(map);
  //   }
  //   return userModel;
  // }

  // set userData(QwnerModel? user) {
  //   _putData(_userData, jsonEncode(user));
  // } // user data

  void removeUserData() {
    _sharedPreferences.remove(_userData);
  }

  // user data
  // List<CartModel> get guestCart {
  //   String data = _getData(_guestCart, "");
  //   if (data.isEmpty) return [];
  //   var decodedList = jsonDecode(_getData(_guestCart, null));
  //   List<CartModel> carts = [];
  //   decodedList.forEach((element) {
  //     carts.add(CartModel.fromJson(element));
  //   });

  //   return carts;
  // }

  // set guestCart(List<CartModel>? cart) {
  //   _putData(_guestCart, jsonEncode(cart));
  // } // user data

  // EmployeeInfoModel? get loadEmployeeData {
  //   var jsonEncode = _getData(_employeeInfo, null);
  //   EmployeeInfoModel? userModel;
  //   if (jsonEncode != null) {
  //     Map<String, dynamic> map = json.decode(jsonEncode);
  //     userModel = EmployeeInfoModel.fromJson(map);
  //   }
  //   return userModel;
  // }

  // void employeeData(EmployeeInfoModel? user) {
  //   _putData(_employeeInfo, jsonEncode(user));
  // } // user data

  void removeEmployeeData() {
    _sharedPreferences.remove(_employeeInfo);
  }
}
