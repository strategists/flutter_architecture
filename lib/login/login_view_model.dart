import 'package:flutter_architecture/arch/arch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ViewModel {
  bool isLogin = false;
  String _token;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool get() => this.isLogin;

  set(bool isLogin) => this.isLogin = isLogin;

  String get token => _token;

  Future<Null> _saveToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("token", token);
  }

  initAuth() {
    _prefs
        .then((p) => p.getString("token"))
        .then((__token) {
          _token = __token;
          if (_token != null && _token != "") {
            isLogin = true;
          }
        })
        .catchError((e) {})
        .whenComplete(this.notifyListeners);
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("token");
    isLogin = false;
    _token = null;
    notifyListeners();
  }

  Future<Null> login(String token) async {
    _saveToken(token);
    _token = token;
    isLogin = true;
    notifyListeners();
  }

  Future<String> readCacheMobile() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString("mobile");
  }

  void writeCacheMobile(String mobile) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("mobile", mobile);
  }
}
