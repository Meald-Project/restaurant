part of 'commande_cubit.dart';

@immutable
sealed class CommandeState {}

final class CommandeInitial extends CommandeState {}
class CommandeLoading extends CommandeState {}

class CommandeLoaded extends CommandeState {
  final List<Map<String, dynamic>> commandes;

  CommandeLoaded(this.commandes);

  @override
  List<Object?> get props => [commandes];
}

class CommandeError extends CommandeState {
  final String error;

  CommandeError(this.error);

  @override
  List<Object?> get props => [error];
}


class CommandeStatusUpdateLoading extends CommandeState {}

class CommandeStatusUpdateLoaded extends CommandeState {
  final Map<String, dynamic> updatedcommande;
   CommandeStatusUpdateLoaded(this.updatedcommande);

  @override
  List<Object?> get props => [updatedcommande];
}

class CommandeStatusUpdateError extends CommandeState {
  final String message;
   CommandeStatusUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}