import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/core/api/api_client.dart';
import 'package:league_master_admin/core/constants/api_constants.dart';
import 'package:league_master_admin/core/errors/dio_exception_extension.dart';
import 'package:league_master_admin/core/errors/failure.dart';
import 'package:league_master_admin/features/tournaments/domain/tournament_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'torunament_repository.g.dart';

@riverpod
tornamentRepository(Ref ref) {
  return TorunamentRepository(ref.watch(dioProvider));
}

final class TorunamentRepository {
  final Dio _dio;

  TorunamentRepository(this._dio);
  Future<List<TournamentModel>> getTournaments() async {
    try {
      final response = await _dio.get(ApiConstants.tournamentsEndpoint);

      if (response.statusCode == 200) {
        return tournamentFromJson(response.data);
      } else {
        throw ServerFailure(
            'Failed to load tournaments: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<void> addTournament(
      {required String name, required int maxTeams}) async {
    try {
      Map params = {"name": name, "max_teams": maxTeams};
      await _dio.post(ApiConstants.addTournamentsEndpoint, data: params);
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<void> updateTournament({required bool status, required int id}) async {
    try {
      Map params = {
        "status": status,
      };
      await _dio.put(ApiConstants.updateTournamentsEndpoint(id), data: params);
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<void> deleteTournament({required int id}) async {
    try {
      await _dio.delete(ApiConstants.updateTournamentsEndpoint(id));
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
  Future<void> addTeamToTournament({required int tournamentId, required int teamId}) async {
    try {
      Map params = {
        "team_id": teamId,
      };
      await _dio.post(ApiConstants.addTeamToTournamentEndpoint(tournamentId), data: params);
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
  Future<void> generateLeague({required int tournamentId}) async {
    try {
      await _dio.post(ApiConstants.generateLeagueEndpoint(tournamentId));
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
