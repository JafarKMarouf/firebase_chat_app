import 'package:firebase_app/pages/loading.dart';
import 'package:firebase_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/Auth/login.dart';
import 'pages/Auth/register.dart';
import 'firebase_options.dart';
import 'pages/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    // _loadinUserInfo();
    // print(FirebaseAuth.instance.currentUser!);
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     Navigator.pushReplacementNamed(context, 'home');
    //     print('===========Signed in==============${user}');
    //   } else {
    //     print('===========Signed out==============$user');
    //   }
    // });
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Firebase App',
      // home: ChatPage(),
      home:Loading(),
      initialRoute:
          (FirebaseAuth.instance.currentUser != null) ? 'home' : 'login',
      routes: {
        'home': (context) => ChatPage(),
        'login': (context) => const Login(),
        'register': (context) => const Register(),
      },
    );
  }
}
