import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/features/tournaments/provider/tournament_provider.dart';
import 'package:league_master_admin/shared/widgets/common_error_widget.dart';
import 'package:league_master_admin/shared/widgets/common_loading.dart';
import 'package:league_master_admin/shared/widgets/common_add_button.dart';
import 'package:league_master_admin/core/errors/failure.dart';

class TournamentsListScreen extends ConsumerWidget {
  const TournamentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournaments = ref.watch(tournamentProvider);
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Tournaments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            CommonAddButton(
              label: 'Add Tournament',
              onPressed: () {
                createTournamentDialog(context, ref);
              },
            ),
          ],
        ),
        Expanded(
          child: tournaments.when(
            data: (tournaments) => Padding(
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
                    label: Text('Date'),
                  ),
                  DataColumn(
                    label: Text('Status'),
                  ),
                  DataColumn(
                    label: Text('Actions'),
                  ),
                ],
                rows: List<DataRow>.generate(
                  tournaments.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(tournaments[index].name)),
                      DataCell(Text(tournaments[index].createdAt.toString())),
                      DataCell(
                        Switch(
                            value: tournaments[index].status == "active"
                                ? true
                                : false,
                            onChanged: (value) {
                              ref
                                  .read(tournamentProvider.notifier)
                                  .updateTournament(
                                      status: value, id: tournaments[index].id);
                            }),
                      ),
                      DataCell(
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ref
                                  .read(tournamentProvider.notifier)
                                  .deleteTournament(id: tournaments[index].id);
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
              onRetry: () => ref.refresh(tournamentProvider),
            ),
          ),
        ),
      ],
    );
  }

  void createTournamentDialog(BuildContext context, WidgetRef ref) {
    return showAboutDialog(context: context, children: [
      AlertDialog(
        title: const Text('Create Tournament'),
        content: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Max Teams',
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
              ref
                  .read(tournamentProvider.notifier)
                  .addTournament(name: 'name', maxTeams: 1);
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      )
    ]);
  }
}
