// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gastos/states/LoginState.dart';
import 'package:gastos/views/AddPage.dart';
import 'package:gastos/views/HomePage.dart';
import 'package:gastos/views/LoginPage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWrapper(),
        routes: {
          '/home': (BuildContext context) => HomePage(),
          '/add': (BuildContext context) => AddPage(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      print(firebaseUser);
      return HomePage();
    }
    return LoginPage();
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<LoginState>(
//       create: (BuildContext context) => LoginState(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/',
//         title: 'GastosApp',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         routes: {
//           '/': (BuildContext context) {
//             var state = Provider.of<LoginState>(context);
//             if (state.isLoggedIn()) {
//               return HomePage();
//             } else
//               return LoginPage();
//           },
//           '/add': (BuildContext context) => AddPage(),
//         },
//       ),
//     );
//   }
// }
