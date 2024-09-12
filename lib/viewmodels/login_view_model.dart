import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meald/models/user.dart';
import 'dart:convert';
import 'package:meald/viewmodels/user_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserViewModel userViewModel;

  LoginViewModel({required this.userViewModel});

  Future<void> login(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
          'motdepasse': passwordController.text,
        }),
      );

      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final role = responseData['user']['role'];
        final int id = responseData['user']['user_id'];

        print('ID: $id');

        userViewModel.setId = id;
        userViewModel.setName = responseData['user']['nom'];
        userViewModel.setEmail = responseData['user']['email'];
        userViewModel.setRole = role;

        print('User ID set to: ${userViewModel.getId}');
        print('User Name set to: ${userViewModel.getName}');
        print('User Email set to: ${userViewModel.getEmail}');
        print('User Role set to: ${userViewModel.getRole}');

        switch (role) {
          case 'client':
            Navigator.of(context).pushReplacementNamed('/homePageClient');
            break;
          case 'resto':
            Navigator.of(context).pushReplacementNamed('/homePage_restaurant');
            break;
          case 'livreur':
            Navigator.of(context).pushReplacementNamed('/homePage_livreur');
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Rôle inconnu.')),
            );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de la connexion ! Veuillez réessayer.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur est survenue. Veuillez réessayer.')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
