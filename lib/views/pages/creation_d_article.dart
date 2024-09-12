import 'package:flutter/material.dart';
import 'footer.dart';



class CreationDArticle extends StatefulWidget {
  const CreationDArticle({Key? key}) : super(key: key);

  @override
  _CreationDArticleState createState() => _CreationDArticleState();
}

class _CreationDArticleState extends State<CreationDArticle> {
  List<String> _ingredients = [
    'Tomato',
    'Lettuce',
    'Cheese',
    'Bacon',
    'Onion'
  ];
  List<String> _selectedIngredients = [];
  List<String> _categories = ['Fast Food', 'Fine Dining', 'Cafe', 'Casual Dining'];
  String? _selectedCategory;
  bool _isPopupVisible = false;

  void _togglePopupVisibility() {
    setState(() {
      _isPopupVisible = !_isPopupVisible;
    });
  }

  void _toggleIngredient(String ingredient) {
    setState(() {
      if (_selectedIngredients.contains(ingredient)) {
        _selectedIngredients.remove(ingredient);
      } else {
        _selectedIngredients.add(ingredient);
      }
    });
  }

  void _addNewIngredient(String name) {
    if (name.isNotEmpty) {
      setState(() {
        _ingredients.add(name);
      });
    }
    Navigator.pop(context);
  }

Widget _button(double width) {
 return ElevatedButton(
    onPressed: () {
      // Add your button logic here
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, // Button color
      minimumSize: Size(width, 50), // Button width and height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      'Submit', // Button text
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}

Widget _input(double width) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: Color.fromRGBO(240, 245, 250, 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        hintText: 'Enter text here', // Placeholder text
      ),
    ),
  );
}


  Widget _ingredientCarousel() {
  return Container(
    height: 100, // Increased height to accommodate both icon and text
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _selectedIngredients.length + 1,
      itemBuilder: (context, index) {
        if (index == _selectedIngredients.length) {
          return GestureDetector(
            onTap: _togglePopupVisibility,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 70, // Adjusted width for better layout
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  SizedBox(height: 5), // Spacing between icon and text
                  Text(
                    'Add Ingredient',
                    style: TextStyle(color: Colors.black54, fontSize: 12), // Adjusted text style
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Icon(
                    Icons.fastfood, // Placeholder icon, use an appropriate one for ingredients
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 5), // Spacing between icon and text
              Text(
                _selectedIngredients[index],
                style: TextStyle(color: Colors.black, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    ),
  );
}

  Widget _ingredientPopup() {
    return AlertDialog(
      title: Text('Select Ingredients'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _ingredients.map((ingredient) {
              return ChoiceChip(
                label: Text(ingredient),
                selected: _selectedIngredients.contains(ingredient),
                onSelected: (selected) => _toggleIngredient(ingredient),
                backgroundColor: Colors.green.withOpacity(0.2),
                selectedColor: Colors.green,
                labelStyle: TextStyle(
                  color: _selectedIngredients.contains(ingredient) ? Colors.white : Colors.black,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add New Ingredient'),
                    content: TextField(
                      onSubmitted: _addNewIngredient,
                      decoration: InputDecoration(hintText: 'Ingredient Name'),
                    ),
                    actions: [
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
    children: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Annuler'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Terminé'),
      ),
    ],
  )
],
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _isPopupVisible = false;
            });
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth * 0.4;
    final double containerHeight = 120;
    final double iconSize = 45;
    final double buttonWidth = screenWidth * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: Text('Création d\'un Nouveau Article'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
Text(
                "Ajouter la categorie :",
                style: TextStyle(
                  fontSize: 18,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    hint: Text("Sélectionner une catégorie"),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    items: _categories.map<DropdownMenuItem<String>>((String value) {
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
                "Nom de votre Article * :",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              _input(double.infinity),
              SizedBox(height: 20),
              Text(
                "Ajouter des images *:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _addimg(containerWidth, containerHeight, iconSize),
                    SizedBox(width: 10),
                    _addimg(containerWidth, containerHeight, iconSize),
                    SizedBox(width: 10),
                    _addimg(containerWidth, containerHeight, iconSize),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Ajouter le Prix *:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              _input(double.infinity),
              SizedBox(height: 20),
                            Text(
                "Ajouter les ingrédients * :",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              _ingredientCarousel(),
              SizedBox(height: 20),
              Text(
                "Détails * :",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 150,
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
              Center(
                child: _button(buttonWidth),
              ),
              SizedBox(height: 30),
              Footer(),
            ],
          ),
        ),
      ),
      // Show the popup if needed
      persistentFooterButtons: _isPopupVisible
          ? [SizedBox.expand(child: _ingredientPopup())]
          : [],
    );
  }
}

Widget _addimg(double width, double height, double iconSize) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Icon(
        Icons.add_a_photo,
        size: iconSize,
        color: Colors.grey[600],
      ),
    ),
  );}