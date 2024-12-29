import 'package:flutter/material.dart';
import 'ArticleContent.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

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
                  'Artikel',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _ArticleItem(
              title: "Manfaat ASI bagi Bayi",
              description:
                  "ASI memiliki banyak manfaat untuk bayi, termasuk meningkatkan sistem kekebalan tubuh dan membantu perkembangan otak.",
              imageUrl: 'assets/img/benefits_milk.png',
              onTap: () {
                // Aksi saat artikel dibaca
                Navigator.push(
                  // artikel content
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArticleContentScreen(
                      title: "Manfaat ASI bagi Bayi",
                      content:
                          "Manfaat ASI eksklusif bagi bayi juga bisa membantu perkembangan otak dan fisiknya. Enggak percaya? Masih melansir dari Direktorat Promosi Kesehatan & Pemberdayaan Masyarakat, manfaat ASI eksklusif bisa menunjang sekaligus membantu proses perkembangan otak dan fisik bayi. Hal tersebut dikarenakan, di usia 0 sampai 6 bulan seorang bayi belum diizinkan mengonsumsi nutrisi apapun selain ASI. Oleh karena itu, selama enam bulan berturut-turut, ASI yang diberikan pada Si Kecil tentu saja memberikan dampak yang besar pada pertumbuhan otak dan fisik bayi selama ke depannya. Di samping itu, berbagai penelitian juga telah menunjukkan bahwa bayi yang mendapat ASI, memiliki tingkat kecerdasan yang lebih tinggi.",
                      image: 'assets/img/manfaat-asi.png',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _ArticleItem(
              title: "Mengatasi Tantangan dalam Menyusui",
              description:
                  "Menyusui dapat menjadi tantangan bagi ibu baru. Artikel ini memberikan tips untuk mengatasi berbagai tantangan yang muncul.",
              imageUrl: 'assets/img/coping_with_breastfeeding.png',
              onTap: () {
                // Aksi saat artikel dibaca
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArticleContentScreen(
                        title: "Mengatasi Tantangan Menyusui",
                        content:
                            "Menyusui adalah pengalaman yang sangat berharga bagi ibu dan bayi, namun seringkali dihadapkan pada berbagai tantangan yang dapat mempengaruhi kenyamanan dan keberhasilan proses tersebut. Salah satu masalah umum yang dihadapi ibu adalah nyeri dan ketidaknyamanan pada puting susu, yang sering disebabkan oleh perlekatan bayi yang tidak tepat, sehingga penting bagi ibu untuk memastikan posisi menyusui yang benar dan menggunakan krim lanolin untuk mengurangi rasa sakit. Selain itu, masalah produksi ASI yang tidak stabil juga sering muncul, baik itu pasokan ASI yang rendah akibat frekuensi menyusui yang tidak memadai atau kelebihan ASI yang dapat menyebabkan payudara bengkak dan saluran tersumbat, sehingga ibu perlu menyusui secara teratur dan melakukan pemijatan pada area yang bengkak. Kelelahan akibat pola tidur yang terganggu juga menjadi tantangan, terutama ketika bayi perlu menyusu setiap beberapa jam, sehingga ibu disarankan untuk tidur siang saat bayi tidur dan melibatkan pasangan dalam menjaga bayi di malam hari. Terakhir, kesulitan dalam teknik menyusui dapat menambah frustrasi, namun dengan mengikuti kelas laktasi atau berkonsultasi dengan konsultan laktasi, ibu dapat memperoleh panduan dan dukungan yang diperlukan untuk menciptakan pengalaman menyusui yang lebih positif dan nyaman.",
                        image: 'assets/img/coping_with_breastfeeding.png'),
                  ),
                );
              },
            ),
            // Tambahkan artikel lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}

class _ArticleItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const _ArticleItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap, // Menangani tap pada artikel
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              // Gambar artikel
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Deskripsi artikel
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis, // Membatasi panjang deskripsi
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullArticleScreen extends StatelessWidget {
  final String title;
  final String content;

  const FullArticleScreen(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: const TextStyle(fontSize: 16, height: 1.6),
          ),
        ),
      ),
    );
  }
}
