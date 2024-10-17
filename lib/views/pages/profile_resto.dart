import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meald/cubit/restaurant/restaurant_cubit.dart';

import '../../cubit/article/article_cubit.dart';
import 'creation_d_article.dart';

class ProfileResto extends StatefulWidget {
  const ProfileResto({Key? key}) : super(key: key);

  @override
  _ProfileRestoState createState() => _ProfileRestoState();
}

class _ProfileRestoState extends State<ProfileResto> {
  String _selectedCategory = "Breakfast";
  final box = GetStorage();
  bool isloading = false;
  bool isloading1 = false;
  bool emptyArticle = false;
  Map<String, dynamic> restaurant = {};
  List<Map<String, dynamic>> article = [];
  bool showDropdown = false; // To manage dropdown visibility
  String? _newCategory; // To store selected category

  Widget _menuItem(String category) {
    bool isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          BlocProvider.of<ArticleCubit>(context)
              .fetchArticleByCategory(_selectedCategory, restaurant['id']);
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fastfood,
            color: isSelected ? Color.fromARGB(255, 255, 70, 3) : Colors.grey,
            size: MediaQuery.of(context).size.width * 0.08,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            category,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: isSelected ? Color.fromARGB(255, 255, 70, 3) : Colors.grey,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 2,
              width: MediaQuery.of(context).size.width * 0.1,
              color: Color.fromARGB(255, 255, 70, 3),
            ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
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
                item['img']!,
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
                  item['name']!,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    item['description']!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[700],
                    ),
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
  void initState() {
    super.initState();
    BlocProvider.of<RestaurantCubit>(context)
        .fetchRestaurantById(box.read("userId"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<RestaurantCubit, RestaurantState>(
              listener: (context, state) {
                if (state is RestaurantDetailLoading) {
                  setState(() {
                    isloading = true;
                  });
                } else if (state is RestaurantDetailLoaded) {
                  setState(() {
                    restaurant = state.restaurant;
                    _selectedCategory = restaurant['category'][0];
                    isloading = false;
                    BlocProvider.of<ArticleCubit>(context)
                        .fetchArticleByCategory(
                            restaurant['category'][0], restaurant['id']);
                  });
                } else if (state is CategoryAdded) {
                  // Update the restaurant when category is added
                  setState(() {
                    restaurant = state.updatedRestaurant;
                  });
                } else if (state is RestaurantDetailError ||
                    state is CategoryAddFailed) {
                  setState(() {
                    isloading = false;
                  });
                  _showErrorDialog(context, (state as dynamic).message);
                }
              },
              builder: (context, state) {
                if (isloading || restaurant.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: const Color.fromRGBO(112, 74, 209, 1),
                    ),
                  );
                } else if (state is CategoryAdding) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: const Color.fromRGBO(255, 70, 3, 1),
                    ),
                  );
                } else {
                  return CustomScrollView(
                    slivers: [
                      _buildSliverAppBar(context),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.04,
                          ),
                          child: _buildRestaurantDetails(context),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      flexibleSpace: FlexibleSpaceBar(
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              restaurant['name'] ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
        background: Image.network(
          restaurant['img'] ?? '',
          fit: BoxFit.cover,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 249, 248, 248),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildRestaurantDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              restaurant['localisation'] ?? '',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        const Text(
          "Infos :",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Container(
          padding: const EdgeInsets.all(10),
          color: const Color.fromARGB(86, 238, 238, 238),
          child: Text(restaurant['description'] ?? ''),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        const Text(
          "Menu :",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _buildCategoryMenu(),
        _buildDropdownMenu(), // Display dropdown for adding category
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$_selectedCategory Items",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            // Add article button
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green),
              onPressed: () {
                // Navigate to the CreateArticlePage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateArticlePage(
                      restaurantName: restaurant['name'],
                      selectedCategory: _selectedCategory,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        BlocConsumer<ArticleCubit, ArticleState>(
          listener: (context, state) {
            if (state is ArticleRestoLoading) {
              setState(() {
                isloading1 = true;
              });
            } else if (state is ArticleRestoLoaded) {
              setState(() {
                if (state.articles.isEmpty) {
                  emptyArticle = true;
                }
                article = state.articles;
                isloading1 = false;
              });
            } else if (state is ArticleRestoError) {
              setState(() {
                isloading1 = false;
              });
              _showErrorDialog(context, state.message);
            }
          },
          builder: (context, state) {
            if (isloading1) {
              return Center(
                child: CircularProgressIndicator(
                  color: const Color.fromRGBO(112, 74, 209, 1),
                ),
              );
            } else if (article.isEmpty) {
              return Center(child: Text("No restaurant data available"));
            } else {
              return Column(
                children: article.map((item) => _buildItemCard(item)).toList(),
              );
            }
          },
        ),
      ],
    );
  }

  // Method to build category menu with an "Add" button and dropdown
  Widget _buildCategoryMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Existing menu categories
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: (restaurant['category'] as List<dynamic>?)
                        ?.map((category) => Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: _menuItem(category),
                            ))
                        .toList() ??
                    [],
              ),
            ),
          ),
        ),

        // Add button
        IconButton(
          icon: Icon(
            Icons.add,
            color: Color.fromARGB(255, 255, 70, 3),
            size: MediaQuery.of(context).size.width * 0.08,
          ),
          onPressed: () {
            setState(() {
              showDropdown = !showDropdown; // Toggle dropdown visibility
            });
          },
        ),
      ],
    );
  }

  // Display the dropdown when the button is clicked
  Widget _buildDropdownMenu() {
    return showDropdown
        ? Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            child: DropdownButton<String>(
              value: _newCategory,
              hint: Text('Select a category'),
              items: <String>['Breakfast', 'Lunch', 'Dinner', 'Snacks']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _newCategory = newValue; // Store the selected category
                  showDropdown = false; // Hide dropdown after selection
                  if (_newCategory != null) {
                    // Trigger the category addition in the RestaurantCubit
                    BlocProvider.of<RestaurantCubit>(context)
                        .addCategory(_newCategory!);
                  }
                });
              },
            ),
          )
        : Container(); // Return an empty container if dropdown is hidden
  }
}
