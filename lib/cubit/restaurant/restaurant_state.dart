part of 'restaurant_cubit.dart';

@immutable
sealed class RestaurantState {}

final class RestaurantInitial extends RestaurantState {}
class RestaurantDetailLoading extends RestaurantState {}

class RestaurantDetailLoaded extends RestaurantState {
  final Map<String, dynamic> restaurant;
  RestaurantDetailLoaded(this.restaurant);
}

class RestaurantDetailError extends RestaurantState {
  final String message;
  RestaurantDetailError(this.message);
}
class CategoryAdding extends RestaurantState {}

class CategoryAdded extends RestaurantState {
  final Map<String, dynamic> updatedRestaurant;
   CategoryAdded(this.updatedRestaurant);

  @override
  List<Object?> get props => [updatedRestaurant];
}

class CategoryAddFailed extends RestaurantState {
  final String message;
   CategoryAddFailed(this.message);

  @override
  List<Object?> get props => [message];
}