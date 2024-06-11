import 'dart:convert';
import 'package:cartao_acessorios/modules/login/utils/shared_preferences.dart/usuario_shared_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  final String _key = 'usuarioLogin';

  Future save(String email, String password) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(
      _key,
      jsonEncode({"email": email, 'password': password}),
    );
  }

  Future isAuth() async {
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.getString(_key);

    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);

      return UserSharedModel(
          email: mapUser['email'], password: mapUser['password']);
    }
  }

  Future logout() async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }
}
