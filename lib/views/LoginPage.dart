import 'package:flutter/material.dart';
import 'package:gastos/styles/Styles.dart';
import 'package:gastos/widgets/LoginForm.dart';
import 'package:gastos/provider/LoginState.dart';

bool rememberMe = false;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    "Iniciar Sesión",
                    style: titleStyle,
                  ),
                  SizedBox(height: 30.0),
                  emailForm(),
                  SizedBox(height: 30.0),
                  paswordForm(),
                  forgotPassword(),
                  Container(
                    height: 20.0,
                    child: Row(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                            checkColor: Colors.green,
                            activeColor: Colors.white,
                          ),
                        ),
                        Text(
                          'Recuérdame',
                          style: inputTitleStyle,
                        ),
                      ],
                    ),
                  ),
                  loginButton(context),
                  signIn(),
                  signInWith(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
