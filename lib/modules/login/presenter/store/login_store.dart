import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/login/repository/contract/authentication.dart';
import 'package:cartao_acessorios/modules/login/services/local_auth/local_auth.dart';
import 'package:cartao_acessorios/modules/login/services/salve_storage/contract/storage_user.dart';
import 'package:flutter/material.dart';

class LoginStore {
  final ValueNotifier<bool> initialState = ValueNotifier<bool>(true);

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  late ValueNotifier<String> success = ValueNotifier<String>('');

  String? _email;
  setEmail(String value) => _email = value;
  getEmail() => _email;

  String? _password;
  setPassword(String value) => _password = value;
  getPassword() => _password;

  final IStorageUser storage;

  final LocalAuthService localAuth = LocalAuthService();

  final IAuthenticationRepository authentication;

  LoginStore({required this.authentication, required this.storage});

  Future authenticationEmailAndPassword() async {
    initialState.value = false;
    if (_email == null || _email!.length < 5 || !_email!.contains("@")) {
      error.value = 'Email inválido';
    } else if (_password == null || _password!.length < 8) {
      error.value = 'senha inválida: $_password';
    } else {
      isLoading.value = true;

      try {
        final result = await authentication.authEmailAndPassword(
            email: _email!, password: _password!);

        await storage.setUserStorage(email: _email!, password: _password!);
        success.value = result;
        error.value = '';
      } on DatasourceError catch (e) {
        error.value = e.message;
        // print(error.value);
      } on RepositoryError catch (e) {
        error.value = e.message;
      } catch (e) {
        error.value = e.toString();
        // print(error.value);
      }
    }

    isLoading.value = false;
  }

  Future<bool> checkCanAuthomaticLogin() async {
    final usuarioStorage = await storage.getUserStorage();

    if (usuarioStorage.email.isNotEmpty && usuarioStorage.password.isNotEmpty) {
      // print(await localAuth.isBiometricAvailable());
      return await localAuth.isBiometricAvailable();
    } else {
      return false;
    }
  }

  Future getUserStorage() async {
    final bool faceCredential = await localAuth.authenticate();

    if (faceCredential) {
      final usuarioStorage = await storage.getUserStorage();

      if (usuarioStorage.email.isNotEmpty &&
          usuarioStorage.password.isNotEmpty) {
        _email = usuarioStorage.email;
        _password = usuarioStorage.password;
        authenticationEmailAndPassword();
      }
    }
  }
}
