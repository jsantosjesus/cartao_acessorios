import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/login/repository/contract/authentication.dart';
import 'package:cartao_acessorios/modules/login/utils/shared_preferences.dart/prefs_service.dart';
import 'package:cartao_acessorios/modules/login/utils/shared_preferences.dart/usuario_shared_model.dart';
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

  final PrefsService shared = PrefsService();

  final IAuthenticationRepository authentication;

  LoginStore({required this.authentication});

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

        await shared.save(_email!, _password!);
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

  Future getUserShared() async {
    final usuarioShared = await shared.isAuth();

    if (usuarioShared is UserSharedModel) {
      _email = usuarioShared.email;
      _password = usuarioShared.password;
      authenticationEmailAndPassword();
    }
  }
}
