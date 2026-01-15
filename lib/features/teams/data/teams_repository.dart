import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/core/api/api_client.dart';
import 'package:league_master_admin/core/constants/api_constants.dart';
import 'package:league_master_admin/core/errors/dio_exception_extension.dart';
import 'package:league_master_admin/core/errors/failure.dart';
import 'package:league_master_admin/features/teams/domain/teams_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teams_repository.g.dart';

@riverpod
teamsRepository(Ref ref) => TeamsRepository(ref.watch(dioProvider));

final class TeamsRepository {
  final Dio _dio;

  TeamsRepository(this._dio);

  Future<List<TeamModel>> getTeams() async {
    try {
      final response = await _dio.get(ApiConstants.teamsEndpoint);

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => TeamModel.fromJson(e))
            .toList();
      } else {
        throw ServerFailure('Failed to load teams: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<TeamModel> addTeam(TeamModel team) async {
    try {
      final response =
          await _dio.post(ApiConstants.teamsEndpoint, data: team.toJson());

      if (response.statusCode == 201) {
        return TeamModel.fromJson(response.data);
      } else {
        throw ServerFailure('Failed to add team: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<TeamModel> updateTeam(int id, TeamModel team) async {
    try {
      final response = await _dio
          .put("${ApiConstants.teamsEndpoint}/$id", data: {"name": team.name});

      if (response.statusCode == 200) {
        return TeamModel.fromJson(response.data);
      } else {
        throw ServerFailure('Failed to update team: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<void> deleteTeam(int id) async {
    try {
      final response = await _dio.delete("${ApiConstants.teamsEndpoint}/$id");

      if (response.statusCode == 204) {
        return;
      } else {
        throw ServerFailure('Failed to delete team: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
