import 'package:equatable/equatable.dart';
import 'package:tdd_app/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];

  String get errorMessage => '$statusCode Error : $message';
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(APIException apiException)
      : this(
            message: apiException.message, statusCode: apiException.statusCode);
}
