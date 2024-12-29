import 'package:flutter/material.dart';

class ArticleContentScreen extends StatelessWidget {
  const ArticleContentScreen({
    Key? key,
    required this.title,
    required this.content,
    required this.image,
  }) : super(key: key);

  final String title;
  final String content;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade100,
        title: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.book),
              backgroundColor: Colors.grey.shade100,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Fredoka'),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Atur radius sesuai kebutuhan
                child: Image.asset(
                  image,
                  fit: BoxFit.cover, // Atur fit sesuai kebutuhan
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(content,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w400)),
            )
          ],
        ),
      )),
    );
  }
}
