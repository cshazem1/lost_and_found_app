import 'dart:io';
import 'package:dio/dio.dart';

enum NetworkExceptionType {
  requestCancelled,
  unauthorizedRequest,
  badRequest,
  notFound,
  requestTimeout,
  noInternetConnection,
  unexpectedError,
}

class Failure {
  final NetworkExceptionType type;
  final String? message;

  Failure._(this.type, [this.message]);

  static Failure requestCancelled() =>
      Failure._(NetworkExceptionType.requestCancelled, "Request was cancelled");

  static Failure unauthorizedRequest(String message) =>
      Failure._(NetworkExceptionType.unauthorizedRequest, message);

  static Failure badRequest() =>
      Failure._(NetworkExceptionType.badRequest, "Bad request");

  static Failure notFound() =>
      Failure._(NetworkExceptionType.notFound, "Resource not found");

  static Failure requestTimeout() =>
      Failure._(NetworkExceptionType.requestTimeout, "Request timeout");

  static Failure noInternetConnection() =>
      Failure._(NetworkExceptionType.noInternetConnection, "No internet connection");

  static Failure unexpectedError() =>
      Failure._(NetworkExceptionType.unexpectedError, "Unexpected error occurred");

  static Failure fromResponse(Response? response) {
    if (response == null) {
      return Failure.unexpectedError();
    }

    switch (response.statusCode) {
      case 400:
        return Failure.badRequest();
      case 401:
        return Failure.unauthorizedRequest("Unauthorized: ${response.statusMessage}");
      case 404:
        return Failure.notFound();
      case 408:
        return Failure.requestTimeout();
      default:
        return Failure.unexpectedError();
    }
  }

  static Failure fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return Failure.requestCancelled();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure.requestTimeout();
      case DioExceptionType.badResponse:
        return Failure.fromResponse(error.response);
      case DioExceptionType.connectionError:
        return Failure.noInternetConnection();
      case DioExceptionType.unknown:
      default:
        if (error.error is SocketException) {
          return Failure.noInternetConnection();
        }
        return Failure.unexpectedError();
    }
  }

  String getErrorMessage() {
    return message ?? "An error occurred";
  }
}
