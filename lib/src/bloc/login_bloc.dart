import 'package:bloc_login_demo/src/bloc/authorization_bloc.dart';
import 'package:bloc_login_demo/src/resources/repository.dart';
import 'package:bloc_login_demo/src/utilities/validation_mixin.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with ValidationMixin {
  Repository repository = Repository();

  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (email, password) => true);
  Stream<bool> get loading => _loadingData.stream;

  void submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    login(validEmail, validPassword);
  }

  void login(String email, String password) async {
    String token = await repository.login(email, password);
    _loadingData.sink.add(false);
    authBloc.openSession(token);
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}
