import 'dart:developer';
import 'dart:io';
import 'package:notification_app/core/data/models/exceptions.dart';

abstract class Failure {
  String message;
}

class AuthFailure extends Failure {
  final String message;
  final String failureCode;

  AuthFailure(
      {this.message = 'An error occurred, please try again.',
      this.failureCode});
}

class UnknownFailure extends Failure {
  final String message;

  UnknownFailure(this.message);
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message);
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure({this.message});
}

Failure handleException(Exception e) {
  log(e.toString());
  if (e is SocketException)
    return NetworkFailure(
      message:
          "Looks like you're not connected to the internet.\nCheck your internet conenction and try again",
    );
  if (e is ServerException) {
    return ServerFailure(e.message);
  } else if (e is NetworkException) {
    return NetworkFailure(message: e.message);
  }
  return UnknownFailure("An unknown error occurred. Please try again");
}
