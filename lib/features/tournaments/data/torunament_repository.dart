import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/core/api/api_client.dart';
import 'package:league_master_admin/core/constants/api_constants.dart';
import 'package:league_master_admin/features/tournaments/domain/tournament_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'torunament_repository.g.dart';

@riverpod
tornamentRepository(Ref ref){
  return TorunamentRepository(ref.watch(dioProvider));
}

class TorunamentRepository {
  final Dio _dio;

  TorunamentRepository(this._dio);
Future<List<TournamentModel>> getTournaments() async {
  final response = await _dio.get(ApiConstants.tournamentsEndpoint);

  if (response.statusCode == 200) {
    return tournamentFromJson(response.data);
  } else {
    throw Exception('Failed to load tournaments');
  }
 
}

}