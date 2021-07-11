import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastos/components/Button.dart';
import 'package:gastos/provider/LoginState.dart';
import 'package:gastos/views/HomePage.dart';
import 'package:gastos/views/RegisterPage.dart';
import 'package:provider/provider.dart';

var scaffoldKey = new GlobalKey<ScaffoldState>();

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    if (user.photoURL == null) {
      user.updatePhotoURL(
          "https://www.cruzyortiz.com/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png");
    }

    return new Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("${user.displayName}"),
            accountEmail: Text("${user.email}"),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("${user.photoURL}"),
              ),
            ),
          ),
          listItems(FontAwesomeIcons.userAlt, "Cuenta", () => {}),
          listItems(Icons.exit_to_app, "Salir", () {
            alertDialog(context);
          })
        ],
      ),
    );
  }

  Widget listItems(IconData icon, String name, Function() callback) {
    return ListTile(
      title: Text(name),
      leading: Icon(icon),
      onTap: callback,
    );
  }
}

void alertDialog(BuildContext context) {
  var alert = AlertDialog(
    title: Text(
      "¿Seguro que desea salir?",
      style: TextStyle(
        color: Colors.red,
      ),
    ),
    content: Text("Se cerrará sesión."),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "Cancelar",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          context.read<AuthService>().signOut();
          Navigator.of(context).pop();
        },
        child: const Text(
          "Aceptar",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    ],
  );
  showDialog(context: context, builder: (BuildContext context) => alert);
}
