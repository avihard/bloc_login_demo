import 'auth_provider.dart';

class Repository {
  final AuthProvider appAuthProvider = AuthProvider();

  Future<String> login(String email, String password) =>
      appAuthProvider.login(email: email, password: password);
}
