import 'package:flutter/material.dart';

class ParametresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: ListView(
        children: [
          _buildListItem(context, 'Informations Personnelles', () => _showPersonalInfoDialog(context)),
          _buildListItem(context, 'Sécurité', () => _showSecurityDialog(context)),
          _buildListItem(context, 'Support', () => _showSupportDialog(context)),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void _showPersonalInfoDialog(BuildContext context) {
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Informations Personnelles'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Nom de famille'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Adresse principale'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              // Implement save logic here
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _showSecurityDialog(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _repeatPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Sécurité'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            TextField(
              controller: _repeatPasswordController,
              decoration: InputDecoration(labelText: 'Répéter le mot de passe'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              // Implement save logic here
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    final TextEditingController _feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Veuillez nous faire part de vos retours ou propositions pour l\'application.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Votre retour',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              // Implement send feedback logic here
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Envoyer'),
          ),
        ],
      ),
    );
  }
}
