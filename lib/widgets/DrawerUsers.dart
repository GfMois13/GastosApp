import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

Widget UsersDrawe() {
  final User? user = auth.currentUser;
  final uid = user!.uid;

  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("A"),
          accountEmail: Text(uid),
          currentAccountPicture: new CircleAvatar(),
        ),
      ],
    ),
  );
}
