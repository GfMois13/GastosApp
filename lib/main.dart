// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gastos/states/LoginState.dart';
import 'package:gastos/views/AddPage.dart';
import 'package:gastos/views/HomePage.dart';
import 'package:gastos/views/LoginPage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
      create: (BuildContext context) => LoginState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'GastosApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (BuildContext context) {
            var state = Provider.of<LoginState>(context);
            if (state.isLoggedIn()) {
              return HomePage();
            } else
              return LoginPage();
          },
          '/add': (BuildContext context) => AddPage(),
        },
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isLoggedIn = false;

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<LoginState>(
//       create: (BuildContext context) => LoginState(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/',
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         routes: {
//           '/': (BuildContext context) {
//             var state = Provider.of<LoginState>(context);
//             if (state.isLoggedIn()) {
//               return HomePage();
//             } else
//               return LoginPage(
//                 onLoginSuccess: () {
//                   setState(() {
//                     _isLoggedIn = true;
//                   });
//                 },
//               );
//           },
//           '/add': (BuildContext context) => AddPage(),
//         },
//       ),
//     );
//   }
// }
