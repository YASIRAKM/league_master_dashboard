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
  // 1. Create the router instance
  // Note: We do NOT watch authProvider here. Watching here destroys the router on change.
  final router = GoRouter(
    initialLocation: '/dashboard',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // 2. Read the current state inside the redirect function
      // Using ref.read() here gets the latest value without rebuilding the router
      final authState = ref.read(authProvider);

      final isLoading = authState.isLoading;
      // Strict check: User is authenticated ONLY if state is AsyncData AND value is true.
      final isAuthenticated =
          authState is AsyncData<bool> && (authState.value == true);
      
      final isLoginRoute = state.uri.path == '/login';

      debugPrint(
          'Redirect Check: Load=$isLoading, Auth=$isAuthenticated, Path=${state.uri.path}');

      // If loading, don't interfere with navigation yet
      if (isLoading) return null;

      // If not authenticated and not on login page, go to login
      if (!isAuthenticated && !isLoginRoute) {
        debugPrint('Redirecting to /login');
        return '/login';
      }

      // If authenticated and on login page, go to dashboard
      if (isAuthenticated && isLoginRoute) {
        debugPrint('Redirecting to /dashboard');
        return '/dashboard';
      }

      // Otherwise, stay where you are
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

  // 3. Setup a listener to manually refresh the router when Auth changes
  ref.listen(authProvider, (previous, next) {
    // This tells GoRouter to re-run the 'redirect' logic defined above
    router.refresh(); 
  });

  return router;
}