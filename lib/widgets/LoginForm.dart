import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastos/provider/GoogleProvider.dart';
import 'package:gastos/provider/LoginState.dart';
import 'package:gastos/styles/Styles.dart';
import 'package:gastos/views/LoginPage.dart';
import 'package:provider/provider.dart';

final TextEditingController _emailController = new TextEditingController();
final TextEditingController _passwdController = new TextEditingController();
bool _rememberMe = false;

Widget emailForm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "Email",
        style: inputTitleStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xFF6CA8F1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 60.0,
        child: TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: "Introduce tu email",
            hintStyle: hintText,
          ),
        ),
      ),
    ],
  );
}

Widget paswordForm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "Contraseña",
        style: inputTitleStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xFF6CA8F1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 60.0,
        child: TextField(
          controller: _passwdController,
          keyboardType: TextInputType.text,
          obscureText: true,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Colors.white,
            ),
            hintText: "Introduce tu contraseña",
            hintStyle: hintText,
          ),
        ),
      ),
    ],
  );
}

Widget forgotPassword() {
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () {},
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        "¿Contraseña olvidada?",
        style: inputTitleStyle,
      ),
    ),
  );
}

Widget loginButton(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () async {
        String email = _emailController.text;
        String password = _passwdController.text;

        _emailController.text = "";
        _passwdController.text = "";

        final sbNoData = SnackBar(
          backgroundColor: Colors.black,
          content: Text('Algún campo no está rellenado. Reviselo'),
        );

        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(sbNoData);
          return;
        }

        await context.read<AuthService>().signIn(
              email: email.trim(),
              password: password.trim(),
            );
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      },
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Text(
        "Iniciar Sesión",
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

Widget signIn() {
  return Column(
    children: <Widget>[
      Text(
        "- O -",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 20.0),
      Text(
        "Registrarse con",
        style: inputTitleStyle,
      )
    ],
  );
}

Widget signInWith(context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/logos/facebook1.jpg'),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            signInWithGoogle();
          },
          child: Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/logos/google.jpg'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
