import 'package:flutter/material.dart';
import 'one-article.dart';

class OngoingOrdersPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
        dishName: 'Pizza Margherita',
        clientCode: 'C1234',
        status: 'En cours',
        clientInfo: 'John Doe, +1 234-567-890'),
    Order(
        dishName: 'Burger Classique',
        clientCode: 'C5678',
        status: 'Commande prête',
        clientInfo: 'Jane Smith, +1 987-654-321'),
    Order(
        dishName: 'Sushi Deluxe',
        clientCode: 'C9101',
        status: 'En cours',
        clientInfo: 'Alice Brown, +1 456-789-012'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordres en Cours'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset('assets/test.png'),
            title: Text(orders[index].dishName),
            subtitle: Text('Client Code: ${orders[index].clientCode}\nStatus: ${orders[index].status}'),
            onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => OneArticle(),
    ),
  );
},
          );
        },
      ),
    );
  }
}

class OrderDetailPage extends StatefulWidget {
  final Order order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String selectedStatus = "En cours";
  final List<String> statusOptions = ['En cours', 'Commande prête', 'Commande annulée'];

  void _showStatusPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Changer le statut'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: statusOptions.map((status) {
              return RadioListTile(
                title: Text(status),
                value: status,
                groupValue: selectedStatus,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.dishName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/test.png'), // Replace with dish image
            SizedBox(height: 16),
            Text(
              widget.order.dishName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Client: ${widget.order.clientInfo}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Code Client: ${widget.order.clientCode}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Note: Ajouter plus de fromage', 
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _showStatusPopup,
                child: Text('Ajouter un statut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Order {
  final String dishName;
  final String clientCode;
  final String status;
  final String clientInfo;

  Order({
    required this.dishName,
    required this.clientCode,
    required this.status,
    required this.clientInfo,
  });
}
