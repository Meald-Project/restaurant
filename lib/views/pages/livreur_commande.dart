import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/commande/commande_cubit.dart';

class LivreurCommandePage extends StatefulWidget {
  const LivreurCommandePage({Key? key}) : super(key: key);

  @override
  _LivreurCommandePageState createState() => _LivreurCommandePageState();
}

class _LivreurCommandePageState extends State<LivreurCommandePage> {
  String _selectedCategory = 'On The Way'; // Default to 'Comming'

  @override
  void initState() {
    super.initState();
    // Fetch commandes with status 0 initially
    BlocProvider.of<CommandeCubit>(context).fetchCommandesWithStatusZero(3);
  }

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
    });

    // Trigger the fetch based on the category
    if (category == 'On The Way') {
      BlocProvider.of<CommandeCubit>(context).fetchCommandesWithStatusZero(3);
    } else if (category == 'Arrived') {
      BlocProvider.of<CommandeCubit>(context).fetchCommandesWithStatusZero(4);
    }
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
      case 'On The Way':
        return 0;
      case 'Arrived':
        return width / 2; // Adjusted for three items

      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Livreur"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryItem('On The Way'),
                _buildCategoryItem('Arrived'),
              ],
            ),
            SizedBox(
                height:
                    20), // Add some space between categories and the underline
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
                      width: MediaQuery.of(context).size.width /
                          2, // Adjusted for three items
                      color: Color.fromARGB(255, 8, 86, 11),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 20), // Add some space before the notifications list

            Expanded(
              child: BlocConsumer<CommandeCubit, CommandeState>(
                  listener: (context, state) {
                if (state is CommandeError) {
                  // Show a SnackBar or other side effects when there's an error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
                if (state is CommandeStatusUpdateError) {
                  // Show a SnackBar or other side effects when there's an error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              }, builder: (context, state) {
                if (state is CommandeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CommandeLoaded) {
                  if (state.commandes.isEmpty) {
                    // Display 'No commands' message if the list is empty
                    return Center(
                      child: Text(
                        'No commands',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.commandes.length,
                      itemBuilder: (context, index) {
                        final commande = state.commandes[index];
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  16.0), // Increase padding for larger notification field
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      8.0), // Add vertical margin for spacing
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                commande['client_id'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            (commande['status'] == 4)
                                                ? SizedBox()
                                                : IconButton(
                                                    onPressed: () {
                                                      // Handle check button press
                                                      final currentStatus =
                                                          commande['status'];
                                                      BlocProvider.of<
                                                                  CommandeCubit>(
                                                              context)
                                                          .updateCommandeStatus(
                                                              commande['id'],
                                                              currentStatus);
                                                      print(
                                                          "Checked: ${commande['client_id']}");
                                                    },
                                                    icon: Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: Colors.green),
                                                  )
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Status: ${commande['status']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                                height: 1,
                                color: Colors
                                    .grey[300]), // Line after each notification
                          ],
                        );
                      },
                    );
                  }
                } else {
                  return Center(child: Text('No notifications found.'));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
