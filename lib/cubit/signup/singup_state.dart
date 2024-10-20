part of 'singup_cubit.dart';

@immutable
sealed class SingupState {}

final class SingupInitial extends SingupState {}
class SingupLoading extends SingupState {}

class SingupLoaded extends SingupState {
  final String successMessage;
  SingupLoaded(this.successMessage);
}

class SingupError extends SingupState {
  final String errorMessage;
  SingupError(this.errorMessage);
}