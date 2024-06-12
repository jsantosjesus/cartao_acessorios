import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    // print(canAuthenticateWithBiometrics);
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    print(availableBiometrics.isNotEmpty);

    if (availableBiometrics.isNotEmpty) {
      return canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    } else {
      return false;
    }
  }

  Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: 'Por favor, autentique-se para acessar o app.',
      options: const AuthenticationOptions(biometricOnly: false),
    );
  }
}
