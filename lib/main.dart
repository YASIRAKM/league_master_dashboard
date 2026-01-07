import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // Import for usePathUrlStrategy
import 'core/router/app_router.dart';
import 'core/theme/theme_provider.dart';
import 'core/theme/app_theme.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: LeagueMasterAdminApp()));
}

class LeagueMasterAdminApp extends ConsumerWidget {
  const LeagueMasterAdminApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeNotifierProvider);

    return MaterialApp.router(
      title: 'LeagueMaster Admin',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
