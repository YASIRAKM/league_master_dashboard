import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/core/errors/failure.dart';
import 'package:league_master_admin/features/teams/domain/teams_model.dart';
import 'package:league_master_admin/features/teams/provider/teams_provider.dart';
import 'package:league_master_admin/shared/widgets/common_add_button.dart';
import 'package:league_master_admin/shared/widgets/common_error_widget.dart';
import 'package:league_master_admin/shared/widgets/common_loading.dart';

class TeamsView extends ConsumerWidget {
  const TeamsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamsProviderProvider);
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Teams',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            CommonAddButton(
              label: 'Add Team',
              onPressed: () {
                createTeamDialog(context, ref);
              },
            ),
          ],
        ),
        Expanded(
          child: teams.when(
            data: (teams) => Padding(
              padding: const EdgeInsets.all(16),
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(
                    label: Text('ID'),
                    size: ColumnSize.S,
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Logo'),
                  ),
                  DataColumn(
                    label: Text('Captain ID'),
                  ),
                  DataColumn(
                    label: Text('Created At'),
                  ),
                  DataColumn(
                    label: Text('Actions'),
                  ),
                ],
                rows: List<DataRow>.generate(
                  teams.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text('${teams[index].id}')),
                      DataCell(Text(teams[index].name ?? 'N/A')),
                      DataCell(teams[index].logoUrl != null
                          ? SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.network(teams[index].logoUrl!),
                            )
                          : const Text('N/A')),
                      DataCell(Text('${teams[index].captainId ?? "N/A"}')),
                      DataCell(Text(teams[index].createdAt.toString())),
                      DataCell(
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ref
                                  .read(teamsProviderProvider.notifier)
                                  .deleteTeam(teams[index].id!);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            loading: () => const CommonLoading(),
            error: (error, stackTrace) => CommonErrorWidget(
              message: error is Failure ? error.message : error.toString(),
              onRetry: () => ref.refresh(teamsProviderProvider),
            ),
          ),
        ),
      ],
    );
  }

  void createTeamDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final logoUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Team'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: logoUrlController,
              decoration: const InputDecoration(
                labelText: 'Logo URL',
              ),
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
              final team = TeamModel(
                name: nameController.text,
                logoUrl: logoUrlController.text.isEmpty
                    ? null
                    : logoUrlController.text,
              );
              ref.read(teamsProviderProvider.notifier).addTeam(team);
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
