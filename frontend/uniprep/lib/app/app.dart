import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uniprep/app/routes.dart';
import 'package:uniprep/app/theme/app_theme.dart';
import 'package:uniprep/features/auth/auth_repository.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);


    return MaterialApp.router(
      title: 'UniPrep - Apti Ka Baapp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (_) {
          return auth.when(
      data: (user) {
        if (user == null) {
          return loggedOutRoutes;
        }

        return loggedInRoutes;
      },
      loading: () => loggedOutRoutes,
      error: (_, __) => loggedOutRoutes,
    );
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}