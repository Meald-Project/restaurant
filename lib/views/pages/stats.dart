import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  String _selectedStat = '';
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleContainer(String stat) {
    setState(() {
      if (_selectedStat == stat && _controller.isCompleted) {
        _controller.reverse();
      } else {
        _selectedStat = stat;
        _controller.forward();
      }
    });
  }

  void _closeContainer() {
    if (_controller.isCompleted) {
      _controller.reverse();
    }
  }

  Widget _statistic(String stat, String type, double width) {
    return GestureDetector(
      onTap: () => _toggleContainer(stat),
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 203, 230, 252),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              stat,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              type,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.location_city),
            SizedBox(width: 4),
            Text('Localisation'),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double statWidth = constraints.maxWidth * 0.4;
          double spacing = constraints.maxWidth * 0.05;

          return Stack(
            children: [
              GestureDetector(
                onTap: _closeContainer,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statistic("Stat 1", "Orders en Cours", statWidth),
                          SizedBox(width: spacing),
                          _statistic("Stat 2", "Order Request", statWidth),
                        ],
                      ),
                      SizedBox(height: spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statistic("Stat 3", "Clients", statWidth),
                          SizedBox(width: spacing),
                          _statistic("Stat 4", "Livreurs", statWidth),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (_selectedStat.isNotEmpty)
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      bottom: -400 + (400 * _animation.value),
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap:
                            () {}, // Prevents closing when tapping inside the sheet
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 5,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(16.0),
                                height: 5,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '20 Running Orders',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: _closeContainer,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      5, // Update with actual number of orders
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  'assets/test.png',
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      '#Breakfast',
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      'Chicken Thai Biriyani',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text('ID: 32053'),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      '\$60',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Handle Done action
                                                    },
                                                    child: const Text('Done'),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      // Handle Cancel action
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
