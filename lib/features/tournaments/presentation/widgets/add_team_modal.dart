import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/features/teams/domain/teams_model.dart';
import 'package:league_master_admin/features/teams/provider/teams_provider.dart';
import 'package:league_master_admin/features/tournaments/data/torunament_repository.dart';
import 'package:league_master_admin/features/tournaments/provider/tournament_provider.dart';
import 'package:league_master_admin/shared/widgets/common_dropdown.dart';
import 'package:league_master_admin/shared/widgets/common_button.dart';
import 'package:league_master_admin/shared/utils/snackbar_utils.dart';

class AddTeamToTournamentModal extends ConsumerStatefulWidget {
  final int tournamentId;

  const AddTeamToTournamentModal({super.key, required this.tournamentId});

  @override
  ConsumerState<AddTeamToTournamentModal> createState() =>
      _AddTeamToTournamentModalState();
}

class _AddTeamToTournamentModalState
    extends ConsumerState<AddTeamToTournamentModal> {
  TeamModel? selectedTeam;

  @override
  Widget build(BuildContext context) {
    final teamsState = ref.watch(teamsProviderProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Team to Tournament',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          teamsState.when(
            data: (teams) {
              if (teams.isEmpty) {
                return const Text('No teams available to add');
              }
              return SharedDropdown<TeamModel>(
                value: selectedTeam,
                items: teams,
                hint: 'Select Team',
                itemLabel: (team) => team.name ?? 'Unnamed Team',
                onChanged: (team) {
                  setState(() {
                    selectedTeam = team;
                  });
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Error loading teams: $error'),
          ),
          const SizedBox(height: 24),
          CommonButton(
            text: 'Add Team',
            onPressed: selectedTeam == null
                ? null
                : () {
                    ref.read(tournamentProvider.notifier).addTeamToTournament(
                        tournamentId: widget.tournamentId,
                        teamId: selectedTeam!.id ?? 0);
                    Navigator.pop(context);
                    SnackbarUtils.showSuccess(
                      context,
                      'Added ${selectedTeam?.name} to tournament ${widget.tournamentId}',
                    );
                  },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
