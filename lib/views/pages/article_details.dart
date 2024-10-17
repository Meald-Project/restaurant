import 'package:flutter/material.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({super.key});

  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails de la nourriture"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/test.png",
                        width: double.infinity,
                        height: 270,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 35,
                        left: 20,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Dejeuner",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Nom de l'article",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$60",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 8, 86, 11),
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "4.9",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 8, 86, 11) ,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '(10 notes)',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(children: [
                    Container(
                      height: 2,
                      color: Colors.grey[300],
                      margin: EdgeInsets.only(top: 15),
                    ),
                  ]
                  ),
                  SizedBox(height: 15,),
                  Text("Les Ingrediants :"),
                  SizedBox(height: 15,),
                  Text("Les Detaills :"),
                  SizedBox(height: 15,),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                    ),
                  )
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
