import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SingupCubit() : super(SingupInitial());

  // Sign up using FirebaseAuth, create a restaurant document, and upload images
  Future<void> signUpAndAddRestaurant({
    required String email,
    required String password,
    required String restaurantName,
    File? imageResto, 
    File? imagePatente, 
  }) async {
    try {
      emit(SingupLoading());

      // Sign up the user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;

      // Prepare the restaurant data with a default deactivated status
      Map<String, dynamic> restaurantData = {
        'email': email,
        'name': restaurantName,
       
        'isActivated': false,  // Set the user as deactivated by default
      };

      // Upload images to Firebase Storage and add URLs to the restaurant data
      if (imageResto != null) {
        String restoImageUrl = await _uploadImageToFirebase(imageResto, "restaurants");
        restaurantData['img'] = restoImageUrl;
      }
      if (imagePatente != null) {
        String patenteImageUrl = await _uploadImageToFirebase(imagePatente, "patente");
        restaurantData['patante'] = patenteImageUrl;
      }

      // Add the restaurant data to Firestore using the UID as the document ID
      await _firestore.collection('restaurant').doc(uid).set(restaurantData);

      emit(SingupLoaded('Restaurant added successfully with UID: $uid, user is deactivated'));
    } catch (e) {
      emit(SingupError('Failed to add restaurant: ${e.toString()}'));
    }
  }

  // Upload image to Firebase Storage
  Future<String> _uploadImageToFirebase(File image, String folder) async {
    try {
      Reference storageReference = _storage.ref().child('$folder/${image.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Image upload failed: ${e.toString()}");
    }
  }
}
