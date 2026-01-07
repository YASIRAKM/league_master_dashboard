import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class TournamentsListScreen extends StatelessWidget {
  const TournamentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          10,
          (index) => DataRow(
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text('Tournament ${index + 1}')),
              DataCell(Text('2023-10-${index + 1}')),
              DataCell(Text(index % 2 == 0 ? 'Active' : 'Completed')),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
