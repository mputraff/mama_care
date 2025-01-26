import 'package:flutter/material.dart';

class CardArticle extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String author;
  final String source;
  final VoidCallback onTap;

  const CardArticle(
      {Key? key,
      required this.title,
      required this.image,
      required this.description,
      required this.author,
      required this.source,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 110,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 125, 159, 168).withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 0,
                      blurRadius: 1.8,
                      offset: Offset(0, 1),
                    ),
                  ]),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Fredoka',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  width: 220, // Atur lebar sesuai kebutuhan
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
                Row(children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFF2EFE7),
                    ),
                    child: Text(
                      author,
                      style: TextStyle(
                          fontFamily: 'Fredoka',
                          color: Colors.black,
                          fontSize: 13),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFF2EFE7),
                    ),
                    child: Text(
                      source,
                      style: TextStyle(
                          fontFamily: 'Fredoka',
                          color: Colors.black,
                          fontSize: 13),
                    ),
                  ),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
