import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/tournaments/presentation/tournaments_list_screen.dart';
import '../../shared/admin_scaffold.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      // Strict check: User is authenticated ONLY if state is AsyncData AND value is true.
      final isAuthenticated =
          authState is AsyncData<bool> && (authState.value == true);
      final isLoginRoute = state.uri.path == '/login';

      debugPrint(
          'Redirect Check: Load=$isLoading, Auth=$isAuthenticated, Path=${state.uri.path}');

      if (isLoading) return null;

      if (!isAuthenticated && !isLoginRoute) {
        debugPrint('Redirecting to /login');
        return '/login';
      }

      if (isAuthenticated && isLoginRoute) {
        debugPrint('Redirecting to /dashboard');
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AdminScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const Center(child: Text('Dashboard')),
          ),
          GoRoute(
            path: '/tournaments',
            builder: (context, state) => const TournamentsListScreen(),
          ),
        ],
      ),
    ],
  );
}
