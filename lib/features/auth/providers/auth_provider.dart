import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:league_master_admin/features/auth/domain/auth_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  final _storage = const FlutterSecureStorage();

  @override
  FutureOr<bool> build() async {
    final token = await _storage.read(key: 'auth_token');
    return token != null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      log('Attempting login for: $email -- START', name: 'AuthDebug');
      AuthResponse authResponse =
          await ref.read(authRepositoryProvider).login(email, password);

      log('Login API returned success', name: 'AuthDebug');
      log('User info: ${authResponse.user.username}, Role: "${authResponse.user.role}"',
          name: 'AuthDebug');

      if (authResponse.user.role == 'admin') {
        log('Role check PASSED. Saving token.', name: 'AuthDebug');
        await _storage.write(key: 'auth_token', value: authResponse.token);
        state = const AsyncValue.data(true);
      } else {
        log('Role check FAILED. Role is "${authResponse.user.role}". Expected "admin".',
            name: 'AuthDebug');
        await _storage.delete(key: 'auth_token');
        throw Exception('Access Denied: Admin privileges required.');
      }
    } catch (e, st) {
      log('Login Exception caught: $e', name: 'AuthDebug');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    state = const AsyncValue.data(false);
  }
}
