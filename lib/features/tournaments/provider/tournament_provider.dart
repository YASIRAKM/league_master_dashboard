import 'package:league_master_admin/features/tournaments/data/torunament_repository.dart';
import 'package:league_master_admin/features/tournaments/domain/tournament_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tournament_provider.g.dart';

@riverpod
class Tournament extends _$Tournament {
  @override
  FutureOr<List<TournamentModel>> build() async {
    return await getTournaments();
  }

  Future<List<TournamentModel>> getTournaments() async {
    state = const AsyncValue.loading();
    try {
      List<TournamentModel> tournaments =
          await (ref.read(tornamentRepositoryProvider) as TorunamentRepository)
              .getTournaments();
      state = AsyncValue.data(tournaments);
      return tournaments;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<void> addTournament(
      {required String name, required int maxTeams}) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(tornamentRepositoryProvider) as TorunamentRepository)
          .addTournament(name: name, maxTeams: maxTeams);
      await getTournaments();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateTournament({required bool status, required int id}) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(tornamentRepositoryProvider) as TorunamentRepository)
          .updateTournament(status: status, id: id);
      await getTournaments();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteTournament({required int id}) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(tornamentRepositoryProvider) as TorunamentRepository)
          .deleteTournament(id: id);
      await getTournaments();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addTeamToTournament({required int tournamentId, required int teamId}) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(tornamentRepositoryProvider) as TorunamentRepository)
          .addTeamToTournament(tournamentId: tournamentId, teamId: teamId);
      await getTournaments();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  Future<void> generateLeague({required int tournamentId}) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(tornamentRepositoryProvider) as TorunamentRepository)
          .generateLeague(tournamentId: tournamentId);
      await getTournaments();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
