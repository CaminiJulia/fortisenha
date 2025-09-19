import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // gerado pelo flutterfire configure

import 'theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart'; // 👈 NOVO

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FortisenhaApp());
}

class FortisenhaApp extends StatelessWidget {
  const FortisenhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fortisenha',
      theme: buildFortiTheme(),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/forgot': (_) => const ForgotPasswordScreen(),
        '/home': (_) => const HomeScreen(), // 👈 NOVO
      },
    );
  }
}
