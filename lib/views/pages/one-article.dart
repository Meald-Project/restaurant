import 'package:flutter/material.dart';

class OneArticle extends StatefulWidget {
  const OneArticle({Key? key}) : super(key: key);

  @override
  _OneArticleState createState() => _OneArticleState();
}

class _OneArticleState extends State<OneArticle> {
  String _selectedSize = "M";
  bool _isLiked = false;
  bool _showClientInfo = true; // Toggles between client and livreur info

  // Sample data for client and livreur
  final Map<String, String> clientInfo = {
    "Name": "John Doe",
    "Code": "12345",
    "Phone": "+1 234 567 890",
  };

  final Map<String, String> livreurInfo = {
    "Name": "En attente ...", // Initially waiting for confirmation
    "Code": "",
    "Phone": "",
  };

  Widget _sizeSelector(String size) {
    bool isSelected = _selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = size;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF006F3D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _informationSection() {
    Map<String, String> info = _showClientInfo ? clientInfo : livreurInfo;

    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _showClientInfo ? "Client Information" : "Livreur Information",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text("Name: ${info['Name']}"),
              SizedBox(height: 8),
              Text("Code: ${info['Code']}"),
              SizedBox(height: 8),
              Text("Phone: ${info['Phone']}"),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showClientInfo = !_showClientInfo;
              });
            },
            child: Text(
              _showClientInfo ? "Switch to Livreur" : "Switch to Client",
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dishDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        "Dish Description: A delicious grilled kebab with a mix of spices, served with fresh vegetables and a side of sauce.",
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _mealStatusButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            _showStatusPopup();
          },
          child: Text(
            "Ajouter un statut",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showStatusPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("En préparation"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Prêt à livrer"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Commande annulée"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _ingredientSelector(IconData icon, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.green),
          SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Kebab mechwi',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),
                      ),
                    ),
                    background: Stack(
                      children: [
                        Image.asset(
                          'assets/test.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: IconButton(
                            icon: Icon(
                              _isLiked ? Icons.favorite : Icons.favorite_border,
                              color: _isLiked ? Colors.green : Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                _isLiked = !_isLiked;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _informationSection(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Ingredients:",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                            _ingredientSelector(Icons.local_pizza, "Cheese"),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                            _ingredientSelector(Icons.local_pizza, "Tomato"),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                            _ingredientSelector(Icons.grain, "Onion"),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      _dishDescription(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      _mealStatusButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
