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
}
