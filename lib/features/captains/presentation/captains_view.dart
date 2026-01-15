import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/features/captains/domain/captain_model.dart';
import 'package:league_master_admin/features/captains/provider/captains_provider.dart';
import 'package:league_master_admin/shared/utils/snackbar_utils.dart';
import 'package:league_master_admin/shared/widgets/common_add_button.dart';

class CaptainsView extends ConsumerWidget {
  const CaptainsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We don't have a list of captains to display yet, so we just show the header and add button.
    // In a real scenario, we would watch a provider that fetches captains.

    // Listen for errors or success
    ref.listen(captainsProviderProvider, (previous, next) {
      next.whenOrNull(
          error: (error, stackTrace) =>
              SnackbarUtils.showError(context, error.toString()),
          data: (_) {
            // Verify previous was loading to confirm this is a completion of an action
            if (previous?.isLoading ?? false) {
              SnackbarUtils.showSuccess(
                  context, 'Captain created successfully');
            }
          });
    });

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Captains',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            CommonAddButton(
              label: 'Add Captain',
              onPressed: () {
                createCaptainDialog(context, ref);
              },
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
                'Captain Management\n(List functionality not available yet)'),
          ),
        ),
      ],
    );
  }

  void createCaptainDialog(BuildContext context, WidgetRef ref) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Captain'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (usernameController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                SnackbarUtils.showError(context, 'Please fill in all fields');
                return;
              }

              final captain = CaptainModel(
                username: usernameController.text,
                password: passwordController.text,
                role: 'captain',
              );
              ref.read(captainsProviderProvider.notifier).addCaptain(captain);
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
