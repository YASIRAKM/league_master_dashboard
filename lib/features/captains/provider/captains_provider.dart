import 'package:league_master_admin/features/captains/data/captains_repository.dart';
import 'package:league_master_admin/features/captains/domain/captain_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'captains_provider.g.dart';

@riverpod
class CaptainsProvider extends _$CaptainsProvider {
  @override
  FutureOr<void> build() {
    // No state to fetch initially for now as per requirements
    return null;
  }

  Future<void> addCaptain(CaptainModel captain) async {
    state = const AsyncValue.loading();
    try {
      await (ref.read(captainsRepositoryProvider) as CaptainsRepository)
          .addCaptain(captain);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
