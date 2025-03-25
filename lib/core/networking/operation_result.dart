import 'package:freezed_annotation/freezed_annotation.dart';
part 'operation_result.freezed.dart';

@freezed
abstract class OperationResult<T> with _$OperationResult<T> {
  const factory OperationResult.success(T data) = Success<T>;
  const factory OperationResult.failure(String error) = Failure<T>;
}
 
 // This Class is used to represent the result of an operation. It can either be a success or a failure.
 // same api_result class but with a different name.