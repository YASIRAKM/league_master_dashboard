import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../domain/auth_models.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(dioProvider));
}

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      log(response.requestOptions.uri.toString(), name: "login url");

      if (response.statusCode == 200) {
        log(response.data.toString());
        return AuthResponse.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        log("401 Unauthorized - Invalid Credentials", name: "auth");
        throw Exception('Invalid credentials');
      }

      log(e.toString(), name: "login error");
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ??
            'Login failed: ${e.response?.statusCode}');
      }
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      log(e.toString(), name: "login error");
      throw Exception('Login failed: $e');
    }
  }
}
