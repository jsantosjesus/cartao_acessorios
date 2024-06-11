import 'dart:convert';

import 'package:cartao_acessorios/modules/login/utils/salve_storage/contract/storage_user.dart';
import 'package:cartao_acessorios/modules/login/utils/salve_storage/contract/usuario_storage_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuritStorage extends IStorageUser {
  final String _key = 'usuarioLogin';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  @override
  Future<UserStorageModel> getUserStorage() async {
    final String? userStorage = await _secureStorage.read(key: _key);

    if (userStorage != null) {
      var mapUser = jsonDecode(userStorage);

      return UserStorageModel(
          email: mapUser['email'], password: mapUser['password']);
    } else {
      throw Error();
    }
  }

  @override
  Future removeUserStorage() {
    // TODO: implement removeUserStorage
    throw UnimplementedError();
  }

  @override
  Future setUserStorage(
      {required String email, required String password}) async {
    await _secureStorage.write(
        key: _key, value: jsonEncode({"email": email, 'password': password}));
  }
}
