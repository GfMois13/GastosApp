import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastos/provider/LoginState.dart';
import 'package:gastos/views/RegisterPage.dart';
import 'package:gastos/widgets/DrawerUsers.dart';
import 'package:provider/provider.dart';

class UIButton extends StatefulWidget {
  final String buttonText;
  const UIButton({Key? key, required this.buttonText}) : super(key: key);

  @override
  _UIButtonState createState() => _UIButtonState();
}

class _UIButtonState extends State<UIButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          final sbNoData = SnackBar(
            backgroundColor: Colors.black,
            content: Text('Algún campo no está rellenado. Reviselo'),
          );
          final sbNotMatch = SnackBar(
            backgroundColor: Colors.black,
            content: Text("Error: Las contraseñas no coinciden."),
          );

          if (emailController.text.isEmpty ||
              passwdController.text.isEmpty ||
              confirmPasswd.text.isEmpty ||
              userController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(sbNoData);
            return;
          }

          if (passwdController.text != confirmPasswd.text) {
            ScaffoldMessenger.of(context).showSnackBar(sbNotMatch);
            return;
          }

          await context.read<AuthService>().signUp(
                email: emailController.text.trim(),
                password: passwdController.text.trim(),
              );

          Navigator.of(context).pop();
          SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
          SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          widget.buttonText,
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
