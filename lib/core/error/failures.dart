import 'package:equatable/equatable.dart';
import 'package:marvel_series/core/error/messages.string.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => this.properties;
}

// General Failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return FailureStrings.serverMessage;
    case CacheFailure:
      return FailureStrings.cacheMessage;
  }
}
