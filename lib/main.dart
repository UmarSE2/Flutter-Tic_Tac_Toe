import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tic_tac_toe/Signup.dart';
import 'package:tic_tac_toe/tictaegame.dart';
import 'Login.dart';
import 'splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Tic Tac toe',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      initialRoute: '/', // Set the initialRoute to your splash screen
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => SignUpPage(),

        '/TicTacToe': (context) => TicTacToeApp(),
      },
    );
  }
}


