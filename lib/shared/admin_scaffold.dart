import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/providers/auth_provider.dart';
import '../core/theme/theme_provider.dart';

class AdminScaffold extends ConsumerWidget {
  final Widget child;

  const AdminScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LeagueMaster Admin'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () =>
                ref.read(themeModeNotifierProvider.notifier).toggle(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Dashboard'),
              onTap: () => context.go('/dashboard'),
            ),
            ListTile(
              title: const Text('Tournaments'),
              onTap: () => context.go('/tournaments'),
            ),
            ListTile(
              title: const Text('Teams'),
              onTap: () => context.go('/teams'),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 800)
            SizedBox(
              width: 250,
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Dashboard'),
                    onTap: () => context.go('/dashboard'),
                  ),
                  ListTile(
                    title: const Text('Tournaments'),
                    onTap: () => context.go('/tournaments'),
                  ),
                  ListTile(
                    title: const Text('Teams'),
                    onTap: () => context.go('/teams'),
                  ),
                ],
              ),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
