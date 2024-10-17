import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meald/views/pages/profile_resto.dart';

import '../../cubit/article/article_cubit.dart'; // For picking images

class CreateArticlePage extends StatefulWidget {
  final String restaurantName;
  final String selectedCategory;

  const CreateArticlePage({
    Key? key,
    required this.restaurantName,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  _CreateArticlePageState createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {
  // TextEditingControllers for article fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final box = GetStorage();
  bool isloading = false;

  // Variables for dynamically added fields
  List<TextEditingController> _ingredientControllers = [];
  List<TextEditingController> _sizeControllers = [];

  // For storing image file
  File? _articleImage;
  final ImagePicker _picker = ImagePicker();

  // Method to add new ingredient field
  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  // Method to remove ingredient field
  void _removeIngredientField(int index) {
    setState(() {
      _ingredientControllers.removeAt(index);
    });
  }

  // Method to add new size field
  void _addSizeField() {
    setState(() {
      _sizeControllers.add(TextEditingController());
    });
  }

  // Method to remove size field
  void _removeSizeField(int index) {
    setState(() {
      _sizeControllers.removeAt(index);
    });
  }

  // Method to pick image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _articleImage = File(pickedFile.path);
      });
    }
  }

  // Logic for saving the article
  void _saveArticle() {
    // Collect all data
    String name = _nameController.text;
    String description = _descriptionController.text;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    List<String> ingredients =
        _ingredientControllers.map((controller) => controller.text).toList();
    List<String> sizes =
        _sizeControllers.map((controller) => controller.text).toList();

    // Here you can add the logic to save the article (e.g., send to the server or save locally)
    print("Article Name: $name");
    print("Description: $description");
    print("Price: $price");
    print("Ingredients: $ingredients");
    print("Sizes: $sizes");
    print("Image Path: ${_articleImage?.path}");

    // Call the addArticle method from ArticleCubit
    context.read<ArticleCubit>().addArticle(
          restaurantName: widget.restaurantName,
          category: widget.selectedCategory,
          name: name,
          description: description,
          price: price,
          ingredients: ingredients,
          sizes: sizes,
          image: _articleImage,
          restaurant_id:
              box.read("userId"), // Optional: if the user selected an image
        );
    // Clear the form after saving
    //_clearForm();
  }

  // Method to clear form after saving
  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _ingredientControllers.clear();
    _sizeControllers.clear();
    setState(() {
      _articleImage = null;
    });
  }

  @override
  void initState() {
    // Debug output to verify received parameters
    print(widget.restaurantName);
    print(widget.selectedCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Article"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ArticleCubit, ArticleState>(
          listener: (context, state) {
            if (state is AddArticleLoading) {
              isloading = true;
            } else if (state is AddArticleLoaded) {
              isloading = false;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileResto()),
              );
            } else if (state is AddArticleError) {
              print("beeeeeeeeeeee5");
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // Return an AlertDialog with a failure message
                  return AlertDialog(
                    title: Text('error'),
                    content: Text(state.errorMessage.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );

              isloading = false;
            }
          },
          builder: (context, state) {
            return isloading == true
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                              color: Color.fromRGBO(112, 74, 209, 1)),
                        ],
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add a new article to ${widget.selectedCategory} for ${widget.restaurantName}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      // Image picker
                      Text(
                        'Image',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      _articleImage != null
                          ? Image.file(
                              _articleImage!,
                              height: 200,
                            )
                          : Text('No image selected.'),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Pick Image'),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Article Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Article Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Dynamic ingredient fields
                      Text(
                        'Ingredients',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ..._ingredientControllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        TextEditingController controller = entry.value;
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    labelText: 'Ingredient',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => _removeIngredientField(index),
                            ),
                          ],
                        );
                      }).toList(),
                      ElevatedButton(
                        onPressed: _addIngredientField,
                        child: Text('Add Ingredient'),
                      ),
                      SizedBox(height: 16),

                      // Dynamic size fields
                      Text(
                        'Sizes',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ..._sizeControllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        TextEditingController controller = entry.value;
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    labelText: 'Size',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => _removeSizeField(index),
                            ),
                          ],
                        );
                      }).toList(),
                      ElevatedButton(
                        onPressed: _addSizeField,
                        child: Text('Add Size'),
                      ),
                      SizedBox(height: 16),

                      // Save button
                      ElevatedButton(
                        onPressed: _saveArticle,
                        child: Text('Save Article'),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
