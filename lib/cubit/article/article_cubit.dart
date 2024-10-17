import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ArticleCubit() : super(ArticleInitial());
  Future<void> fetchArticleByCategory(
      String category, String restaurantId) async {
    try {
      emit(ArticleRestoLoading());

      // Query articles where today_special is true
      QuerySnapshot querySnapshot = await _firestore
          .collection('article')
          .where('restaurant_id', isEqualTo: restaurantId)
          .where('category', isEqualTo: category)
          .get();

      // Include document ID with the data
      List<Map<String, dynamic>> articles = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add the document ID to the map
        return data;
      }).toList();

      print(articles);

      emit(ArticleRestoLoaded(articles));
    } catch (e) {
      print(e);

      emit(ArticleRestoError('Failed to load articles: ${e.toString()}'));
    }
  }

  // Add article to Firestore and upload image to Firebase Storage
  Future<void> addArticle({
    required String restaurant_id,
    required String restaurantName,
    required String category,
    required String name,
    required String description,
    required double price,
    required List<String> ingredients,
    required List<String> sizes,
    File? image, // Image to upload
  }) async {
    try {
      print("ddddddd");
      emit(AddArticleLoading());

      // Prepare the article data
      Map<String, dynamic> articleData = {
        'restaurant_id': restaurant_id,
        'restaurant_name': restaurantName,
        'category': category,
        'name': name,
        'description': description,
        'price': price,
        'ingredients': ingredients,
        'taille': sizes,
        'disponible': true,
        'today_special': false,
        'created_at': FieldValue.serverTimestamp(),
      };
      print("fffff");

      // If an image is provided, upload it to Firebase Storage
      if (image != null) {
        String imageUrl = await _uploadImageToFirebase(image);
        articleData['img'] = imageUrl; // Add the image URL to article data
      }

      // Add the article data to Firestore
      await _firestore.collection('article').add(articleData);

      emit(AddArticleLoaded('Article added successfully'));
    } catch (e) {
      print("here $e");
      emit(AddArticleError('Failed to add article: ${e.toString()}'));
    }
  }

  // Upload image to Firebase Storage
  Future<String> _uploadImageToFirebase(File image) async {
    try {
      print("Start uploading the image.");

      Reference storageReference =
          _storage.ref().child('articles/${image.path.split('/').last}');
      print("Storage reference created: $storageReference");

      // Initiate file upload
      UploadTask uploadTask = storageReference.putFile(image);
      print("Upload task initiated: $uploadTask");

      // Listen to the upload progress
      uploadTask.snapshotEvents.listen((event) {
        print("Upload event: ${event.state}");
      });

      // Wait until the task is complete
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {
        print("Upload complete.");
      });

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Download URL: $downloadUrl");

      return downloadUrl;
    } catch (e) {
      print("Error during image upload: ${e.toString()}");
      throw Exception("Image upload failed: ${e.toString()}");
    }
  }

  /*  Future<String> _uploadImageToFirebase(File image) async {
    try {
      // Create a reference to the Firebase Storage folder
      print("Start uploading the image.");

      Reference storageReference =
          _storage.ref().child('articles/${image.path.split('/').last}');
      print(storageReference);
      // Initiate file upload and await the result
      UploadTask uploadTask = storageReference.putFile(image);
      // print(uploadTask.snapshot);
      uploadTask.snapshotEvents.listen((event) {
        switch (event.state) {
          case TaskState.running:
            print('Upload is running');
            break;
          case TaskState.paused:
            print('Upload is paused');
            break;
          case TaskState.success:
            print('Upload is complete');
            break;
          case TaskState.canceled:
            print('Upload was canceled');
            break;
          case TaskState.error:
            print('A error happened: ${state.toString()}');
            break;
        }
      });
      // Wait until the task is complete
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {
        print("Upload complete.");
      });

      // Get the download URL after successful upload
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Download URL: $downloadUrl");

      return downloadUrl; // Return the image download URL
    } on FirebaseException catch (e) {
      print("Image upload failed: ${e.toString()}");
      throw Exception('Image upload failed: ${e.toString()}');
    }
  } */
}
