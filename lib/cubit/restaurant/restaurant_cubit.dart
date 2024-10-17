import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> restaurant = {};
  RestaurantCubit() : super(RestaurantInitial());
  Future<void> fetchRestaurantById(String restaurantId) async {
    try {
      emit(RestaurantDetailLoading());

      DocumentSnapshot docSnapshot =
          await _firestore.collection('restaurant').doc(restaurantId).get();

      if (docSnapshot.exists) {
        final restaurant = {
          'id': docSnapshot.id,
          ...docSnapshot.data() as Map<String, dynamic>
        };
        this.restaurant = restaurant;
        print(restaurant);
        emit(RestaurantDetailLoaded(restaurant));
      } else {
        emit(RestaurantDetailError('Restaurant not found'));
      }
    } catch (e) {
      emit(RestaurantDetailError('Failed to load restaurant: ${e.toString()}'));
    }
  }

  // Add category to restaurant's category list
  void addCategory(String category) async {
    try {
      emit(CategoryAdding());

      // Fetch the restaurant document
      DocumentReference restaurantRef =
          _firestore.collection('restaurant').doc(restaurant['id']);

      // Check if the category already exists in the Firestore document
      if (!restaurant['category'].contains(category)) {
        // Update Firestore document by adding the new category to the "category" array
        await restaurantRef.update({
          'category': FieldValue.arrayUnion([category]),
        });

        // After updating the Firestore document, fetch the updated restaurant data
        DocumentSnapshot updatedSnapshot = await restaurantRef.get();
        if (updatedSnapshot.exists) {
          final updatedRestaurant = {
            'id': updatedSnapshot.id,
            ...updatedSnapshot.data() as Map<String, dynamic>
          };
          emit(CategoryAdded(updatedRestaurant)); // Emit the updated restaurant
        } else {
          emit(CategoryAddFailed('Restaurant not found'));
        }
      } else {
        emit(CategoryAddFailed('Category already exists'));
      }
    } catch (e) {
      print(e);
      emit(CategoryAddFailed('Error adding category: ${e.toString()}'));
    }
  }
}
