import 'package:dio/dio.dart';

extension DioExceptionExtension on DioException {
  String get errorMessage {
    switch (type) {
      case DioExceptionType.cancel:
        return 'Request to server was cancelled';
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout with server';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with server';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in connection with server';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      case DioExceptionType.badCertificate:
        return 'Bad certificate';
      case DioExceptionType.badResponse:
        return _handleBadResponse(response);
      case DioExceptionType.unknown:
        if (error.toString().contains('SocketException')) {
          return 'No internet connection';
        }
        return 'Unexpected error occurred';
    }
  }

  String _handleBadResponse(Response? response) {
    try {
      if (response?.data != null && response?.data is Map) {
        final data = response?.data;
        if (data['message'] != null) {
          return data['message'].toString();
        }
        if (data['error'] != null) {
          return data['error'].toString();
        }
      }
      switch (response?.statusCode) {
        case 400:
          return 'Bad request';
        case 401:
          return 'Unauthorized access';
        case 403:
          return 'Forbidden access';
        case 404:
          return 'Resource not found';
        case 500:
          return 'Internal server error';
        case 502:
          return 'Bad gateway';
        case 503:
          return 'Service unavailable';
        default:
          return 'Received invalid status code: ${response?.statusCode}';
      }
    } catch (_) {
      return 'Unexpected error occurred';
    }
  }
}
