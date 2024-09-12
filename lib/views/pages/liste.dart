import 'package:flutter/material.dart';
import 'footer.dart';

class Liste extends StatefulWidget {
  const Liste({Key? key}) : super(key: key);

  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  String _selectedCategory = 'Tout';
  bool _isInStock = true; // Track stock status

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _toggleStockStatus() {
    setState(() {
      _isInStock = !_isInStock;
    });
  }

  void _showPopupMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(_isInStock ? 'Hors Stock' : 'En Stock'), // Update the text based on stock status
                onTap: () {
                  _toggleStockStatus();
                  Navigator.pop(context); 
                },
              ),
              ListTile(
                title: Text('Modifier Article'),
                onTap: () {
                  // Handle Modifier Article action
                },
              ),
              ListTile(
                title: Text('Supprimer Article'),
                onTap: () {
                  // Handle Supprimer Article action
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma Liste"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCategoryItem('Tout'),
                      _buildCategoryItem('Petit Déjeuner'),
                      _buildCategoryItem('Déjeuner'),
                      _buildCategoryItem('Diner'),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 2,
                        color: Colors.grey[300],
                        margin: const EdgeInsets.only(top: 15),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        left: _selectedCategoryPosition(context),
                        top: 15,
                        child: Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width / 4,
                          color: const Color.fromARGB(255, 8, 86, 11),
                        ),
                      ),
                    ],
                  ),
                  _detailArticle(),
                  _detailArticle(),
                  _detailArticle(),
                ],
              ),
            ),
          ),
          Footer(), // Place the footer after the scrollable content
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category) {
    bool isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () => _onCategoryTap(category),
      child: Column(
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color.fromARGB(255, 8, 86, 11) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

Widget _detailArticle() {
  return GestureDetector(
    onLongPress: () => _showPopupMenu(context),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 150,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(240, 245, 250, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Image(
                      image: AssetImage("assets/addpic.png"),
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Nom de l'article",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(48, 3, 255, 62),
                          ),
                          child: const Center(
                            child: Text(
                              "Categorie",
                              style: TextStyle(
                                color: Color.fromARGB(255, 8, 86, 11),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "\$19.99",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 8, 86, 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: const Color.fromARGB(255, 8, 86, 11),
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "4.9",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 8, 86, 11),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _isInStock ? 'En Stock' : 'Hors Stock',  // Display stock status here
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
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

  double _selectedCategoryPosition(BuildContext context) {
    switch (_selectedCategory) {
      case 'Tout':
        return 0;
      case 'Petit Déjeuner':
        return MediaQuery.of(context).size.width / 4;
      case 'Déjeuner':
        return MediaQuery.of(context).size.width / 2;
      case 'Diner':
        return 3 * MediaQuery.of(context).size.width / 4;
      default:
        return 0;
    }
  }
}
