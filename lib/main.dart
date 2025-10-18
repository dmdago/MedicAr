import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  // ← Agregar
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppTheme.configureSystemUI();
  runApp(
    const ProviderScope(  // ← Envolver con ProviderScope
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedicAr',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}