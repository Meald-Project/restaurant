import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meald/views/pages/profile_resto.dart';

import '../../cubit/article/article_cubit.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final box = GetStorage();
  bool isloading = false;

  List<TextEditingController> _ingredientControllers = [];
  List<TextEditingController> _sizeControllers = [];

  File? _articleImage;
  final ImagePicker _picker = ImagePicker();

  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredientField(int index) {
    setState(() {
      _ingredientControllers.removeAt(index);
    });
  }

  void _addSizeField() {
    setState(() {
      _sizeControllers.add(TextEditingController());
    });
  }

  void _removeSizeField(int index) {
    setState(() {
      _sizeControllers.removeAt(index);
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _articleImage = File(pickedFile.path);
      });
    }
  }

  void _saveArticle() {
    String name = _nameController.text;
    String description = _descriptionController.text;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    List<String> ingredients =
        _ingredientControllers.map((controller) => controller.text).toList();
    List<String> sizes =
        _sizeControllers.map((controller) => controller.text).toList();

    context.read<ArticleCubit>().addArticle(
          restaurantName: widget.restaurantName,
          category: widget.selectedCategory,
          name: name,
          description: description,
          price: price,
          ingredients: ingredients,
          sizes: sizes,
          image: _articleImage,
          restaurant_id: box.read("userId"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Article"),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.errorMessage.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
              isloading = false;
            }
          },
          builder: (context, state) {
            return isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New Article in ${widget.selectedCategory}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: _articleImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          _articleImage!,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.grey[200],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'No image selected',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.image),
                                  label: const Text("Pick Image"),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: _pickImage,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                  controller: _nameController,
                                  label: 'Article Name'),
                              const SizedBox(height: 16),
                              _buildTextField(
                                  controller: _descriptionController,
                                  label: 'Article Description'),
                              const SizedBox(height: 16),
                              _buildTextField(
                                  controller: _priceController,
                                  label: 'Price',
                                  keyboardType: TextInputType.number),
                            ],
                          ),
                        ),
                      ),
                      _buildDynamicFields(
                        title: 'Ingredients',
                        controllers: _ingredientControllers,
                        addField: _addIngredientField,
                        removeField: _removeIngredientField,
                      ),
                      const SizedBox(height: 16),
                      _buildDynamicFields(
                        title: 'Sizes',
                        controllers: _sizeControllers,
                        addField: _addSizeField,
                        removeField: _removeSizeField,
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: _saveArticle,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 42, 194, 50),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 15.0,
                            ),
                          ),
                          child: const Text(
                            'Save Article',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDynamicFields({
    required String title,
    required List<TextEditingController> controllers,
    required Function addField,
    required Function(int) removeField,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...controllers.asMap().entries.map((entry) {
              int index = entry.key;
              TextEditingController controller = entry.value;
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: title.substring(0, title.length - 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => removeField(index),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: Text('Add $title'),
                onPressed: () => addField(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
