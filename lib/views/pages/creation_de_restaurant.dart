import 'package:flutter/material.dart';

class CreationDeRestaurant extends StatefulWidget {
  const CreationDeRestaurant({Key? key}) : super(key: key);

  @override
  _CreationDeRestaurantState createState() => _CreationDeRestaurantState();
}

class _CreationDeRestaurantState extends State<CreationDeRestaurant> {
  void _onContainerTap() {
    // Handle the tap event here
    print('Container tapped!');
  }

  String? _selectedRestaurantType;
  List<String> _restaurantTypes = ["Fast Food", "Fine Dining", "Cafe", "Casual Dining"];

  Widget _button() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity, // Make the button width responsive
      height: 70,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: () {
                        Navigator.of(context).pushNamed('/homePage_restaurant');

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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600; // Adjust breakpoint as needed

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
                onTap: _onContainerTap,
                child: Container(
                  width: isSmallScreen ? screenWidth * 0.8 : 190,
                  height: isSmallScreen ? (screenWidth * 0.8) * 0.6 : 120,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 245, 250, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Image.asset(
                      "assets/addpic.png",
                      width: 30,
                      height: 30,
                    ),
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Type de votre Restaurant * :",
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                    value: _selectedRestaurantType,
                    hint: Text("sélectionner un type"),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRestaurantType = newValue!;
                      });
                    },
                    items: _restaurantTypes.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Ajouter votre Pattente * :",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _onContainerTap,
                child: Container(
                  width: isSmallScreen ? screenWidth * 0.8 : 190,
                  height: isSmallScreen ? (screenWidth * 0.8) * 0.6 : 120,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 245, 250, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Image.asset(
                      "assets/addpic.png",
                      width: 30,
                      height: 30,
                    ),
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
}
