import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/config/routes.dart';
import '../core/theme/app_theme.dart';
import 'widgets/loading_screen.dart';
import 'widgets/error_screen.dart';
import 'providers/auth_provider.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

class LumoApp extends ConsumerWidget {
  const LumoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Lumo Book App',
      theme: AppTheme.light(),

      // 👉 Use `home:` for your auth gate instead of an "initialRoute"
      home: authState.when(
        data:   (user) => user != null ? const HomePage() : const LoginPage(),
        loading: ()       => const LoadingScreen(),
        error:   (err, _) => ErrorScreen(message: err.toString()),
      ),

      // Named routes for navigation from deep links or secondary pages
      routes: {
        Routes.login:    (_) => const LoginPage(),
        Routes.register: (_) => const RegisterPage(),
        Routes.home:     (_) => const HomePage(),
      },
    );
  }
}
