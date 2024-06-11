import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/login/models/user_model.dart';
import 'package:cartao_acessorios/modules/login/repository/contract/authentication.dart';
import 'package:flutter/material.dart';

class LoginStore {
  final ValueNotifier<bool> initialState = ValueNotifier<bool>(true);

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  late ValueNotifier<UserModel> success = ValueNotifier<UserModel>(
      UserModel(uid: '', nome: '', cpf: '', email: '', telefone: ''));

  String? _email;
  setEmail(String value) => _email = value;

  String? _password;
  setPassword(String value) => _password = value;

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
}
