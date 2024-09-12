import 'package:flutter/material.dart';

class RatesPage extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'John Doe',
      'image': 'assets/user1.png',
      'rating': 4.5,
      'comment': 'Great service! Highly recommend.',
    },
    {
      'name': 'Jane Smith',
      'image': 'assets/user2.png',
      'rating': 5.0,
      'comment': 'Absolutely amazing experience!',
    },
    {
      'name': 'Michael Johnson',
      'image': 'assets/user3.png',
      'rating': 4.0,
      'comment': 'Good, but could improve in some areas.',
    },
    {
      'name': 'Emily Davis',
      'image': 'assets/user4.png',
      'rating': 4.8,
      'comment': 'Loved it! Will definitely come back.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(review['image']),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              review['rating'].toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          review['comment'],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
