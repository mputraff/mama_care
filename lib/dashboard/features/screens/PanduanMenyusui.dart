import 'package:flutter/material.dart';

class PanduanMenyusuiScreen extends StatelessWidget {
  const PanduanMenyusuiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panduan Menyusui")),
      body: ListView(
        children: <Widget>[
          const ListTile(title: Text('Posisi Menyusui')),
          Image.asset('assets/img/breastfeeding_position.png'),
          const ListTile(title: Text('Tips Latching')),
          Image.asset('assets/img/latching_tips.png'),
        ],
      ),
    );
  }
}
