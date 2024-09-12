import 'package:flutter/material.dart';
import 'footer.dart';

class ProfileResto extends StatefulWidget {
  const ProfileResto({Key? key}) : super(key: key);

  @override
  _ProfileRestoState createState() => _ProfileRestoState();
}

class _ProfileRestoState extends State<ProfileResto> {
  String _selectedCategory = "Breakfast"; // Default selected category

  // Example data for items in each category
  final Map<String, List<Map<String, String>>> _menuItems = {
    "Breakfast": [
      {"title": "Omelette", "description": "A classic omelette with cheese.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
      {"title": "Pancakes", "description": "Fluffy pancakes with syrup.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
    ],
    "Sandwiches": [
      {"title": "BLT", "description": "Bacon, lettuce, and tomato sandwich.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
      {"title": "Club Sandwich", "description": "A traditional club sandwich.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
    ],
    "Pizza": [
      {"title": "Margherita", "description": "Tomato, mozzarella, and basil.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
      {"title": "Pepperoni", "description": "Pepperoni and cheese.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
    ],
    "Sushi": [
      {"title": "Sushi Roll", "description": "Traditional sushi roll with fish.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
      {"title": "Sashimi", "description": "Fresh slices of fish.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
    ],
    "Smoothies": [
      {"title": "Berry Blast", "description": "Mixed berry smoothie.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
      {"title": "Tropical", "description": "Mango and pineapple smoothie.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
    ],
    "Drinks": [
      {"title": "Lemonade", "description": "Refreshing lemonade.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
      {"title": "Iced Tea", "description": "Chilled iced tea.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
    ],
    "Plates": [
      {"title": "Steak", "description": "Grilled steak with sides.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
      {"title": "Salmon", "description": "Baked salmon with vegetables.", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAPX72zRye0yKp_n8EXUUkyJ54fn-lsfwwzY_y5uvjg241pHEEgV6UbsJK4iraOf2BZYQ&usqp=CAU"},
    ],
  };

  Widget _menuItem(String category) {
    bool isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fastfood,
            color: isSelected ? Colors.green : Colors.grey,
            size: MediaQuery.of(context).size.width * 0.08,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            category,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 2,
              width: MediaQuery.of(context).size.width * 0.1,
              color: Colors.green,
            ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, String> item) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        // Navigate to article page with item details
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item['image']!,
                width: screenWidth * 0.3,
                height: screenHeight * 0.1,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  item['description']!,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
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
                    title: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          'Nom Resto',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/test.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 249, 248, 248)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            SizedBox(width: 8),
                            Text(
                              "Location du restaurant",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Text(
                          "Infos :",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(86, 238, 238, 238),
                          child: Text("Description du restaurant."),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Text(
                          "Menu :",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _menuItems.keys.map((category) {
                                return Padding(
                                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
                                  child: _menuItem(category),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        Text(
                          "$_selectedCategory Items",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Column(
                          children: _menuItems[_selectedCategory]!
                              .map((item) => _buildItemCard(item))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Footer()
        ],
      ),
    );
  }
}
