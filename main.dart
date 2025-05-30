import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/app_wrapper.dart'; // AppWrapper burada
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReliefApp',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: authService.value.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return AppWrapper(child: const HomePage()); // ✅ Chat butonlu Home
          } else {
            return const LoginPage(); // ❌ Giriş ekranında chat butonu yok
          }
        },
      ),
    );
  }
}
