import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastos/components/Button.dart';
import 'package:gastos/components/InputComponent.dart';
import 'package:gastos/styles/Styles.dart';

final TextEditingController emailController = new TextEditingController();
final TextEditingController passwdController = new TextEditingController();
final TextEditingController confirmPasswd = new TextEditingController();
final TextEditingController userController = new TextEditingController();

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [
                  0.1,
                  0.4,
                  0.7,
                  0.9,
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 48.0,
                vertical: 45.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Crear Usuario",
                    style: titleStyle,
                  ),
                  SizedBox(height: 30.0),
                  UIinputText(
                    title: "Nombre",
                    icon: FontAwesomeIcons.user,
                    text: "Introduce tu Nombre",
                    controller: userController,
                  ),
                  SizedBox(height: 15.0),
                  UIinputText(
                    title: "Email",
                    icon: Icons.email,
                    text: "Introduce tu Email",
                    controller: emailController,
                  ),
                  SizedBox(height: 15.0),
                  UIinputText(
                    title: "Contraseña",
                    icon: FontAwesomeIcons.key,
                    text: "Introduce una contraseña",
                    controller: passwdController,
                    isPassword: true,
                  ),
                  SizedBox(height: 15.0),
                  UIinputText(
                    title: "Confirmar Contraseña",
                    icon: FontAwesomeIcons.key,
                    text: "Introduce otra vez tu contraseña",
                    controller: confirmPasswd,
                    isPassword: true,
                  ),
                  SizedBox(height: 15.0),
                  UIButton(
                    buttonText: "Crear Usuario",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
