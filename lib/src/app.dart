import 'package:bloc_login_demo/src/bloc/authorization_bloc.dart';
import 'package:bloc_login_demo/src/ui/home_screen.dart';
import 'package:flutter/material.dart';

import 'ui/login_screen.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    authBloc.restoreSession();

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: CreateData(),
    );
  }

  CreateData() {
    return StreamBuilder<bool>(
      stream: authBloc.isSessionValid,
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data){
          return HomeScreen();
        }
        return LoginScreen();
      },
    );
  }
}
