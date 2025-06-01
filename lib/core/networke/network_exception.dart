import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum FailureType { network, model, unexpected }

enum NetworkExceptionType {
  requestCancelled,
  unauthorizedRequest,
  badRequest,
  notFound,
  requestTimeout,
  noInternetConnection,
  unexpectedError,
}

abstract class Failure {
  final FailureType type;
  final NetworkExceptionType? networkType;
  final String message;

  const Failure(this.type, this.networkType, this.message);

  @override
  String toString() {
    return 'Failure(type: $type, networkType: $networkType, message: $message)';
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure(NetworkExceptionType networkType, String message)
    : super(FailureType.network, networkType, message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message)
    : super(FailureType.unexpected, null, message);
}

Failure failureFromDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.cancel:
      return const NetworkFailure(
        NetworkExceptionType.requestCancelled,
        "Request was cancelled",
      );

    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkFailure(
        NetworkExceptionType.requestTimeout,
        "Request timeout",
      );

    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode ?? 0;
      switch (statusCode) {
        case 400:
          return const NetworkFailure(
            NetworkExceptionType.badRequest,
            "Bad request",
          );
        case 401:
          return NetworkFailure(
            NetworkExceptionType.unauthorizedRequest,
            "Unauthorized: ${error.response?.statusMessage}",
          );
        case 404:
          return const NetworkFailure(
            NetworkExceptionType.notFound,
            "Resource not found",
          );
        case 408:
          return const NetworkFailure(
            NetworkExceptionType.requestTimeout,
            "Request timeout",
          );
        default:
          return const NetworkFailure(
            NetworkExceptionType.unexpectedError,
            "Unexpected error",
          );
      }

    case DioExceptionType.connectionError:
      if (error.error is SocketException) {
        return const NetworkFailure(
          NetworkExceptionType.noInternetConnection,
          "No internet connection",
        );
      }
      return const NetworkFailure(
        NetworkExceptionType.unexpectedError,
        "Unexpected error",
      );

    case DioExceptionType.unknown:
    default:
      return const NetworkFailure(
        NetworkExceptionType.unexpectedError,
        "Unexpected error",
      );
  }
}

void logAndThrow(String message) {
  const red = '\x1B[31m';
  const reset = '\x1B[0m';
  debugPrint('$red❌ $message$reset');
}
