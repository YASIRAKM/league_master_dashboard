import 'package:league_master_admin/features/teams/data/teams_repository.dart';
import 'package:league_master_admin/features/teams/domain/teams_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teams_provider.g.dart';

@riverpod
class TeamsProvider extends _$TeamsProvider {
  @override
  FutureOr<List<TeamModel>> build() async {
    return await fetchTeams();
  }

  Future<List<TeamModel>> fetchTeams() async {
    state = const AsyncValue.loading();
    try {
      List<TeamModel> res =
          await (ref.read(teamsRepositoryProvider) as TeamsRepository)
              .getTeams();
      state = AsyncValue.data(res);
      return res;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<void> addTeam(TeamModel team) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(teamsRepositoryProvider) as TeamsRepository)
          .addTeam(team);
      await fetchTeams();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateTeam(int id, TeamModel team) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(teamsRepositoryProvider) as TeamsRepository)
          .updateTeam(id, team);
      await fetchTeams();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteTeam(int id) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(teamsRepositoryProvider) as TeamsRepository)
          .deleteTeam(id);
      await fetchTeams();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  } 
}
