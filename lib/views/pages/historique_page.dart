import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: '12345',
      date: '2024-08-25',
      status: 'Completed',
      items: [
        OrderItem(name: 'Pizza Margherita', quantity: 2, price: 12.00),
        OrderItem(name: 'Caesar Salad', quantity: 1, price: 8.00),
      ],
      total: 32.00,
    ),
    Order(
      id: '67890',
      date: '2024-08-24',
      status: 'Pending',
      items: [
        OrderItem(name: 'Sandwich Thon', quantity: 1, price: 10.00),
        OrderItem(name: 'Pack Kids', quantity: 2, price: 15.00),
      ],
      total: 40.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: Column(
        children: [
Container(
      width: 370,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button
            },
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 214, 214, 214),
          hintText: 'Recherchez Des Plats Où Des Restaurants..',
          hintStyle: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    ), 
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Order {
  final String id;
  final String date;
  final String status;
  final List<OrderItem> items;
  final double total;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    required this.total,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${order.date}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${order.status}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: order.status == 'Completed'
                    ? Colors.green
                    : Color.fromARGB(255, 62, 220, 67),
              ),
            ),
            SizedBox(height: 16),
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${item.quantity}x ${item.name}'),
                  Text('\$${item.price.toStringAsFixed(2)}'),
                ],
              ),
            )),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
