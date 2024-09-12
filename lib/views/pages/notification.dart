import 'package:flutter/material.dart';
import 'footer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedCategory = 'Notifications';

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
    });
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
              color: isSelected ? Color.fromARGB(255, 8, 86, 11) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  double _selectedCategoryPosition(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    switch (_selectedCategory) {
      case 'Notifications':
        return 0;
      case 'Messages(3)':
        return width / 3; // Adjusted for three items
      case 'Reviews':
        return 2 * width / 3; // Adjusted for three items
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryItem('Notifications'),
                _buildCategoryItem('Messages(3)'),
                _buildCategoryItem('Reviews'),
              ],
            ),
            SizedBox(height: 20), // Add some space between the categories and the underline
            SizedBox(
              height: 2, // Constrain the height for AnimatedPositioned to work
              child: Stack(
                children: [
                  Container(
                    color: Colors.grey[300],
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left: _selectedCategoryPosition(context),
                    top: 0,
                    child: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width / 3, // Adjusted for three items
                      color: Color.fromARGB(255, 8, 86, 11),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Add some space before the notifications list
            Expanded(
              child: ListView(
                children: List.generate(
                  10, // Number of notifications
                  (index) => Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0), // Increase padding for larger notification field
                        margin: EdgeInsets.symmetric(vertical: 8.0), // Add vertical margin for spacing
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2), // Shadow direction
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/userlogo.png',
                              width: 60, // Increased size
                              height: 60, // Increased size
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Doe',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Notification $index',
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'time',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: Colors.grey[300]), // Line after each notification
                    ],
                  ),
                ),
              ),
            ),
            Footer(),         
          ],
        ),
      ),
    );
  }
}
