import 'package:flutter/material.dart';

class BodyHome extends StatelessWidget {
  final List<Map<String, dynamic>> features = [
    {'icon': Icons.attach_money, 'label': 'Top up'},
    {'icon': Icons.payment, 'label': 'Pay'},
    {'icon': Icons.send, 'label': 'Transfer'},
    {'icon': Icons.shopping_bag, 'label': 'E-shopping'},
    {'icon': Icons.receipt, 'label': 'Bills'},
    {'icon': Icons.videogame_asset, 'label': 'Games'},
    {'icon': Icons.favorite, 'label': 'Charity'},
    {'icon': Icons.more_horiz, 'label': 'More'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          height: 150,
          margin: EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          height: 230,
          width: 400,
          margin: EdgeInsets.all(14),
          
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Features',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Fredoka',
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Jumlah item per baris
                    crossAxisSpacing: 16, // Jarak horizontal antar item
                    mainAxisSpacing: 16, // Jarak vertikal antar item
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue[50], // Warna background
                            borderRadius: BorderRadius.circular(10), // Membulatkan sudut
                          ),
                          child: Icon(
                            features[index]['icon'],
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          features[index]['label'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}