import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/features/tournaments/provider/tournament_provider.dart';

class TournamentsListScreen extends ConsumerWidget {
  const TournamentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournaments = ref.watch(tournamentProvider);
    return tournaments.when(
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
                DataCell(Text(tournaments[index].status)),
                DataCell(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                    IconButton(
                        icon: const Icon(Icons.delete), onPressed: () {}),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}
