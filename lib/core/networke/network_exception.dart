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

class NetworkExceptions {
  final NetworkExceptionType type;
  final String? message;

  NetworkExceptions._(this.type, [this.message]);

  static NetworkExceptions requestCancelled() =>
      NetworkExceptions._(NetworkExceptionType.requestCancelled, "Request was cancelled");

  static NetworkExceptions unauthorizedRequest(String message) =>
      NetworkExceptions._(NetworkExceptionType.unauthorizedRequest, message);

  static NetworkExceptions badRequest() =>
      NetworkExceptions._(NetworkExceptionType.badRequest, "Bad request");

  static NetworkExceptions notFound() =>
      NetworkExceptions._(NetworkExceptionType.notFound, "Resource not found");

  static NetworkExceptions requestTimeout() =>
      NetworkExceptions._(NetworkExceptionType.requestTimeout, "Request timeout");

  static NetworkExceptions noInternetConnection() =>
      NetworkExceptions._(NetworkExceptionType.noInternetConnection, "No internet connection");

  static NetworkExceptions unexpectedError() =>
      NetworkExceptions._(NetworkExceptionType.unexpectedError, "Unexpected error occurred");

  static NetworkExceptions fromResponse(Response? response) {
    if (response == null) {
      return NetworkExceptions.unexpectedError();
    }

    switch (response.statusCode) {
      case 400:
        return NetworkExceptions.badRequest();
      case 401:
        return NetworkExceptions.unauthorizedRequest("Unauthorized: ${response.statusMessage}");
      case 404:
        return NetworkExceptions.notFound();
      case 408:
        return NetworkExceptions.requestTimeout();
      default:
        return NetworkExceptions.unexpectedError();
    }
  }

  static NetworkExceptions fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return NetworkExceptions.requestCancelled();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkExceptions.requestTimeout();
      case DioExceptionType.badResponse:
        return NetworkExceptions.fromResponse(error.response);
      case DioExceptionType.connectionError:
        return NetworkExceptions.noInternetConnection();
      case DioExceptionType.unknown:
      default:
        if (error.error is SocketException) {
          return NetworkExceptions.noInternetConnection();
        }
        return NetworkExceptions.unexpectedError();
    }
  }

  String getErrorMessage() {
    return message ?? "An error occurred";
  }
}
