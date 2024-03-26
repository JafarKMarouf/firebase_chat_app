// ignore_for_file: deprecated_member_use, unused_import

import 'package:firebase_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebase_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/bloc_osbserver.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'firebase_options.dart';
import 'pages/main/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
  // BlocOverrides.runZoned(
  //   () => runApp(const ChatApp()),
  //   blocObserver: AppBlocObserver(),
  // );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Firebase App',
        initialRoute:
            (FirebaseAuth.instance.currentUser != null) ? 'home' : 'login',
        routes: {
          'home': (context) => ChatPage(),
          'login': (context) => LoginPage(),
          'register': (context) => RegisterPage(),
        },
      ),
    );
  }
}
