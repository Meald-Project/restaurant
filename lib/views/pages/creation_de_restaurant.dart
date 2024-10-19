import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubit/signup/singup_cubit.dart'; // Adjust the import to match your project structure

class CreationDeRestaurant extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const CreationDeRestaurant({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  _CreationDeRestaurantState createState() => _CreationDeRestaurantState();
}

class _CreationDeRestaurantState extends State<CreationDeRestaurant> {
  // Controllers for text fields
  final TextEditingController _restaurantNameController =
      TextEditingController();
  final TextEditingController _cinNumberController = TextEditingController();
  final TextEditingController _cinDateController = TextEditingController();

  // Variables for storing picked images
  String? _restaurantLogoPath;
  String? _patenteImagePath;

  // Logic to pick an image from the gallery
  Future<void> _pickImage(String type) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (type == "logo") {
          _restaurantLogoPath = pickedFile.path;
        } else if (type == "patente") {
          _patenteImagePath = pickedFile.path;
        }
      });
    }
  }

  // Widget for the save button
  Widget _button() {
    return BlocConsumer<SingupCubit, SingupState>(
      listener: (context, state) {
        if (state is SingupLoaded) {
          // Navigate to the home page on successful signup
          Navigator.of(context).pushNamed('/homePage_restaurant');
        } else if (state is SingupError) {
          // Show error message if signup fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is SingupLoading) {
          return CircularProgressIndicator(); // Show loading indicator
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ElevatedButton(
            onPressed: () {
              if (_restaurantLogoPath != null && _patenteImagePath != null) {
                // Trigger the signUpAndAddRestaurant method from the cubit
                BlocProvider.of<SingupCubit>(context).signUpAndAddRestaurant(
                  email: widget.email,
                  password: widget.password,
                  restaurantName: _restaurantNameController.text.trim(),
                  imageResto: File(_restaurantLogoPath!), // Logo file
                  imagePatente: File(_patenteImagePath!), // Patente file
                );
              } else {
                // Show error message if images are not selected
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please upload both images")),
                );
              }
            },
            child: Text(
              'Sauvegarder',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    print(widget.email);
    print(widget.name);
    print(widget.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Création De Restaurant",
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Ajouter votre logo",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _pickImage("logo"),
                child: Container(
                  width: isSmallScreen ? screenWidth * 0.8 : 190,
                  height: isSmallScreen ? (screenWidth * 0.8) * 0.6 : 120,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 245, 250, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _restaurantLogoPath == null
                      ? Padding(
                          padding: const EdgeInsets.all(45.0),
                          child: Image.asset(
                            "assets/addpic.png",
                            width: 30,
                            height: 30,
                          ),
                        )
                      : Image.file(
                          File(_restaurantLogoPath!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Nom de votre Restaurant * :",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: isSmallScreen ? screenWidth * 0.8 : 300,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 245, 250, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _restaurantNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Num CIN * :",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: isSmallScreen ? screenWidth * 0.35 : 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 245, 250, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _cinNumberController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text(
                        "Date CIN * :",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: isSmallScreen ? screenWidth * 0.35 : 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 245, 250, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _cinDateController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Ajouter votre Patente * :",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _pickImage("patente"),
                child: Container(
                  width: isSmallScreen ? screenWidth * 0.8 : 190,
                  height: isSmallScreen ? (screenWidth * 0.8) * 0.6 : 120,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 245, 250, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _patenteImagePath == null
                      ? Padding(
                          padding: const EdgeInsets.all(45.0),
                          child: Image.asset(
                            "assets/addpic.png",
                            width: 30,
                            height: 30,
                          ),
                        )
                      : Image.file(
                          File(_patenteImagePath!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 40),
              _button(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers when no longer needed
    _restaurantNameController.dispose();
    _cinNumberController.dispose();
    _cinDateController.dispose();
    super.dispose();
  }
}
