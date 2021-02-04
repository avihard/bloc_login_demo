import 'package:bloc_login_demo/src/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            emailField(bloc),
            passwordField(bloc),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(bloc),
            loadingIndicator(bloc)
          ],
        ),
      ),
    );
  }

  Widget loadingIndicator(LoginBloc bloc) => StreamBuilder<bool>(
        stream: bloc.loading,
        builder: (context, snapshot) {
          return Container(
            child: (snapshot.hasData && snapshot.data)
                ? CircularProgressIndicator()
                : null,
          );
        },
      );

  Widget emailField(LoginBloc bloc) => StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'you@example.com',
                errorText: snapshot.error
            ),
          );
        },
      );

  Widget passwordField(LoginBloc bloc) => StreamBuilder<String>(stream: bloc.password,builder: (context, snapshot) {
    return TextField(
      keyboardType: TextInputType.name,
      onChanged: bloc.changePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'avinashkorat',
        errorText: snapshot.error
      ),
    );
  },);

  Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(stream: bloc.submitValid,builder: (context, snapshot) {
    return RaisedButton(onPressed: (!snapshot.hasData) ? null : bloc.submit,
      child: Text('Login', style: TextStyle(color: Colors.white),),
      color: Colors.blue,
    );

  },);
}
