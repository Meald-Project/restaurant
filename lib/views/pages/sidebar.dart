import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 230, // Height of the DrawerHeader
            color: Colors.green,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Available Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$500.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Withdraw'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0), // Adjust padding
                      minimumSize: Size(100, 36), // Minimum width and height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Parametres'),
            onTap: () {
              Navigator.pushNamed(context, '/parametres');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historique'),
            onTap: () {
              Navigator.pushNamed(context, '/historique');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Ordres'),
            trailing: Text('29K'),
            onTap: () {
              Navigator.pushNamed(context, '/ongoingOrders');
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Avis Clients'),
            onTap: () {
              Navigator.pushNamed(context, '/rates');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Se Deconnecter'),
            onTap: () {
              Navigator.pushNamed(context, '/Login');
            },
          ),
        ],
      ),
    );
  }
}
