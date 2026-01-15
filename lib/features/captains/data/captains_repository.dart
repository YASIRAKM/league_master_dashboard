import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:league_master_admin/core/api/api_client.dart';
import 'package:league_master_admin/core/constants/api_constants.dart';
import 'package:league_master_admin/core/errors/dio_exception_extension.dart';
import 'package:league_master_admin/core/errors/failure.dart';
import 'package:league_master_admin/features/captains/domain/captain_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'captains_repository.g.dart';

@riverpod
captainsRepository(Ref ref) => CaptainsRepository(ref.watch(dioProvider));

final class CaptainsRepository {
  final Dio _dio;

  CaptainsRepository(this._dio);

  Future<void> addCaptain(CaptainModel captain) async {
    try {
      final response = await _dio.post(ApiConstants.registerEndpoint,
          data: captain.toJson());

      if (response.statusCode == 201) {
        return;
      } else {
        throw ServerFailure('Failed to create captain: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.errorMessage);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
