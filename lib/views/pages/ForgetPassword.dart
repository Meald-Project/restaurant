import 'package:flutter/material.dart';
import 'package:meald/viewmodels/login_view_model.dart';
import 'package:meald/viewmodels/user_view_model.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final LoginViewModel viewModel;
  bool codeSent = false;
  String enteredEmailOrPhone = "";

  @override
  void initState() {
    super.initState();
    final userViewModel = UserViewModel();
    viewModel = LoginViewModel(userViewModel: userViewModel);
  }

  Widget _button() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: codeSent ? Colors.green : Color.fromARGB(255, 7, 154, 107),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            codeSent = true;
            enteredEmailOrPhone = viewModel.emailController.text;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (codeSent) Icon(Icons.check, color: Colors.white),
            SizedBox(width: codeSent ? 8 : 0),
            Text(
              codeSent ? 'Code Envoyé' : 'Envoyer Le Code',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _codeInput() {
    if (!codeSent) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          "Code",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 245, 250, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Entrez le code",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            ),
          ),
        ),
        SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Handle the case when the user didn't receive the code
            },
            child: Text(
              "J'ai Pas reçu le code",
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
              ),
            ),
          ),

      ],
    );
  }

  Widget _inputs() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "E-Mail ou num tel",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 245, 250, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: viewModel.emailController,
                    decoration: InputDecoration(
                      hintText: "Entrez votre email ou numero de telephone",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                _button(),
                _codeInput(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 4, 23),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Text(
                'Mot De Passe Oubliée',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            codeSent
                ? 'Un code est envoyé à votre $enteredEmailOrPhone, Veuillez vérifier votre appareil'
                : 'Veillez Entrer Votre E-mail Ou Numero De Telephone Pour Acceder A votre Compte',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(119, 255, 255, 255),
            ),
          ),
          SizedBox(height: 100),
          _inputs(),
        ],
      ),
    );
  }
}
