import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              source: "ALODOKTER",
              title: "Pentingnya Peran Ibu Menyusui bagi Dirinya dan Bayi",
              description:
                  "Peran ibu menyusui sangatlah penting. Tak hanya bagi tumbuh kembang bayi,",
              imageUrl: 'assets/img/coping_with_breastfeeding.png',
              onTap: () async {
                final Uri url = Uri.parse(
                    "https://www.alodokter.com/mengapa-memilih-menyusui");

                if (!await launchUrl(url,
                    mode: LaunchMode.externalApplication)) {
                  // Optional: Tampilkan pesan error jika URL tidak bisa dibuka
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch $url')),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            _ArticleItem(
              source: "CNN Indonesia",
              title: "Mendukbangga Soroti Kebiasaan Ngunyah Sirih saat Hamil",
              description:
                  "[mengunyah sirih] termasuk kultur yang perlu diedukasi. Itu salah satu contohnya, beberapa daerah itu masih ada",
              imageUrl: 'assets/img/cnn.jpeg',
              onTap: () async {
                final Uri url = Uri.parse(
                    "https://www.cnnindonesia.com/gaya-hidup/20241205085734-255-1173920/bahas-stunting-mendukbangga-soroti-kebiasaan-ngunyah-sirih-saat-hamil");

                if (!await launchUrl(url,
                    mode: LaunchMode.externalApplication)) {
                  // Optional: Tampilkan pesan error jika URL tidak bisa dibuka
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch $url')),
                  );
                }
              },
            ),

            const SizedBox(height: 16),
            _ArticleItem(
              source: "Telemed IHC",
              title: "Tips Menjaga Kesehatan Ibu Menyusui",
              description:
                  "Pemberian ASI (air susu ibu) pada si kecil menawarkan ragam manfaat yang baik untuknya.",
              imageUrl: 'assets/img/telemed.jpg',
              onTap: () async {
                final Uri url = Uri.parse(
                    "https://telemed.ihc.id/artikel-detail-202-Tips-Menjaga-Kesehatan-Ibu-Menyusui.html");
                if (!await launchUrl(url,
                    mode: LaunchMode.externalApplication)) {
                  // Optional: Tampilkan pesan error jika URL tidak bisa dibuka
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch $url')),
                  );
                }
              },
            ),

            const SizedBox(height: 16),
            _ArticleItem(
              source: "Okezone",
              title: "Tips Menjaga Kesehatan Ibu Menyusui",
              description:
                  "Pemberian ASI (air susu ibu) pada si kecil menawarkan ragam manfaat yang baik untuknya.",
              imageUrl: 'assets/img/okezone.jpg',
              onTap: () async {
                final Uri url = Uri.parse(
                    "https://lifestyle.okezone.com/amp/2024/12/20/481/3097272/yuk-cari-tahu-6-kondisi-ibu-hamil-yang-perlu-didampingi-konsultan-fetomaternal");
                if (!await launchUrl(url,
                    mode: LaunchMode.externalApplication)) {
                  // Optional: Tampilkan pesan error jika URL tidak bisa dibuka
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch $url')),
                  );
                }
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
  final String source;
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const _ArticleItem({
    required this.source,
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
                      source,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
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
