import 'package:flutter/material.dart';
import 'package:gastos/states/LoginState.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          child: Text('Sign In'),
          onPressed: () {
            Provider.of<LoginState>(context, listen: false).login();
          },
        ),
      ),
    );
  }
}
