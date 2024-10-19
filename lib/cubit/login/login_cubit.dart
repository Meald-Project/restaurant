import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final box = GetStorage();

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());

      // Sign in the user
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Access and store UID
      final userId = userCredential.user!.uid;

      // Check if the user ID exists in the restaurants collection
      final restaurantDoc = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(userId)
          .get();

      if (!restaurantDoc.exists) {
        // If user ID does not exist in the restaurants collection, emit failure and sign out
        await FirebaseAuth.instance.signOut();
        emit(LoginFailure(error: 'Restaurant for this user does not exist.'));
        print('Restaurant not found for user ID: $userId');
        return;
      }
      // Check if the user is activated
      final isActivated = restaurantDoc['isActivated'] ?? false;

      if (!isActivated) {
        // If the user is not activated, sign out and emit failure
        await FirebaseAuth.instance.signOut();
        emit(LoginFailure(error: 'Your account is not activated.'));
        print('User with ID $userId is not activated.');
        return;
      }

      // Store user details in GetStorage if they are authorized
      box.write("userId", userId);
      box.write("email", userCredential.user!.email);
      print(box.read("userId"));

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(error: e.message));
      print(e);
    } catch (e) {
      emit(LoginFailure(error: 'An unexpected error occurred'));
      print(e);
    }
  }
}
