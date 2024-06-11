import 'dart:convert';
import 'package:cartao_acessorios/modules/login/utils/salve_storage/contract/storage_user.dart';
import 'package:cartao_acessorios/modules/login/utils/salve_storage/contract/usuario_storage_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService implements IStorageUser {
  final String _key = 'usuarioLogin';

  @override
  Future<UserStorageModel> getUserStorage() async {
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.getString(_key);

    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);

      return UserStorageModel(
          email: mapUser['email'], password: mapUser['password']);
    } else {
      throw Error();
    }
  }

  @override
  Future removeUserStorage() async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }

  @override
  Future setUserStorage(
      {required String email, required String password}) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(
      _key,
      jsonEncode({"email": email, 'password': password}),
    );
  }
}
