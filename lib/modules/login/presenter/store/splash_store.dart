import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/login/repository/contract/authentication.dart';
import 'package:cartao_acessorios/modules/login/utils/shared_preferences.dart/prefs_service.dart';
import 'package:cartao_acessorios/modules/login/utils/shared_preferences.dart/usuario_shared_model.dart';
import 'package:flutter/material.dart';

class SplashStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  late ValueNotifier<String> success = ValueNotifier<String>('');

  final PrefsService shared = PrefsService();

  final IAuthenticationRepository authentication;

  SplashStore({required this.authentication});

  Future authenticationEmailAndPassword() async {
    final usuarioShared = await shared.isAuth();

    if (usuarioShared is UserSharedModel) {
      print(usuarioShared.email);
      print(usuarioShared.password);
      try {
        final result = await authentication.authEmailAndPassword(
            email: usuarioShared.email, password: usuarioShared.password);

        success.value = result;
        error.value = '';
      } on DatasourceError catch (e) {
        error.value = e.message;
      } on RepositoryError catch (e) {
        error.value = e.message;
      } catch (e) {
        error.value = e.toString();
      }
    } else {
      isLoading.value = false;
      error.value = 'sem usuário';
    }
  }
}
