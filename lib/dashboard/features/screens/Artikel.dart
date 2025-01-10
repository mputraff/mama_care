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
              source: "Artikel ALODOKTER",
              title: "Penyebab Ibu Hamil Muda Lebih Emosional dan Cara Mengatasinya",
              description:
                  "Ditinjau oleh : dr. Kevin Adrian 2 Januari 2025",
              imageUrl: 'assets/img/coping_with_breastfeeding.png',
              onTap: () async {
                final Uri url = Uri.parse(
                    "https://www.alodokter.com/alasan-ibu-hamil-muda-emosional-dan-cara-mengatasinya");

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
              source: "By ALODOKTER",
              title: "Cara Mengatasi Sesak Napas pada Ibu Hamil Saat Tidur",
              description:
                  "Ditinjau oleh : dr. Kevin Adrian 3 Januari 2025",
              imageUrl: 'assets/img/sesak-hamil.jpg',
              onTap: () async {
                final Uri url = Uri.parse(
                    "https://www.alodokter.com/cara-mengatasi-sesak-napas-pada-ibu-hamil-saat-tidur");

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
              source: "By ALODOKTER",
              title: "Fakta di Balik Buah yang Dilarang untuk Ibu Hamil",
              description:
                  "Ditinjau oleh : dr. Kevin Adrian 26 Desember 2024",
              imageUrl: 'assets/img/hamil-duren.jpg',
              onTap: () async {
                final Uri url = Uri.parse(
                    "https://www.alodokter.com/yuk-ketahui-fakta-di-balik-buah-yang-dilarang-untuk-ibu-hamil");
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
              source: "By ALODOKTER",
              title: "4 Penyebab Susah Tidur Malam saat Hamil Muda Dan Cara Mengatasinya",
              description:
                  "Ditinjau oleh : dr. Kevin Adrian 27 Desember 2024",
              imageUrl: 'assets/img/susah-tidur.jpg',
              onTap: () async {
                final Uri url = Uri.parse(
                    "https://www.alodokter.com/susah-tidur-malam-saat-hamil-muda-ini-penjelasannya");
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
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
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
