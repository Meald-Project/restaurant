                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Color.fromARGB(255, 8, 86, 11), size: MediaQuery.of(context).size.width * 0.08),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Text('Notes', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_shipping, color: Color.fromARGB(255, 8, 86, 11), size: MediaQuery.of(context).size.width * 0.08),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Text('Prix livraison', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.schedule, color: Color.fromARGB(255, 8, 86, 11), size: MediaQuery.of(context).size.width * 0.08),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Text('Délai livraison', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                