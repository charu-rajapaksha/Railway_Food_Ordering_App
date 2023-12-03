import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:railway_food_ordering/screen/login_pg.dart';
// ignore: unused_import
import 'package:railway_food_ordering/screen/sign_up.dart';

import 'home_pg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.blue,
          textSelectionTheme:
              TextSelectionThemeData(selectionColor: Colors.red)),
      //home: LoginPage(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (index, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            }
            return LoginPage();
          }),
    );
  }
}
