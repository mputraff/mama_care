import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade100,
        title: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.help_outline_sharp),
              backgroundColor: Colors.grey.shade100,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Fredoka',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'FAQ Ibu Menyusui',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Fredoka',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      
      body: ListView.builder(

        itemCount: faqItems.length,
        itemBuilder: (context, index) {
          final item = faqItems[index];
          return _FAQItem(
            question: item['question']!,
            answer: item['answer']!,
          );
        },
      ),
      
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink.shade100.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
              title: Text(
                widget.question,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontFamily: 'Fredoka',
                ),
              ),
              trailing: Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isExpanded ? null : 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: _isExpanded
                  ? Text(
                      widget.answer,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Fredoka',
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// Data FAQ
const List<Map<String, String>> faqItems = [
  {
    "question": "1. Apa itu latching?",
    "answer": "Latching adalah proses menyusui dengan cara bayi menggigit puting susu dengan mulutnya."
  },
  {
    "question": "2. Bagaimana cara meningkatkan produksi ASI?",
    "answer": "Peningkatan produksi ASI bisa dilakukan dengan menyusui secara rutin dan menjaga pola makan."
  },
  {
    "question": "3. Apa tanda bayi cukup ASI?",
    "answer": "Tanda bayi cukup ASI adalah bayi terlihat kenyang setelah menyusu dan berat badannya naik sesuai dengan usia."
  },
  {
    "question": "4. Apakah bisa menyusui jika sakit?",
    "answer": "Ya, Anda tetap bisa menyusui meskipun sedang sakit, pastikan untuk menjaga kebersihan dan konsultasikan dengan dokter."
  },
  {
    "question": "5. Berapa lama waktu ideal untuk menyusui bayi?",
    "answer": "Idealnya, bayi menyusu selama 15-20 menit pada setiap sisi payudara, namun setiap bayi berbeda."
  },
  {
    "question": "6. Apa yang harus dilakukan jika bayi tidak mau menyusu?",
    "answer": "Cobalah untuk menenangkan bayi dan mencari posisi yang nyaman, atau konsultasikan dengan dokter jika masalah berlanjut."
  },
  {
    "question": "7. Apakah menyusui bisa dilakukan di tempat umum?",
    "answer": "Ya, menyusui di tempat umum diperbolehkan. Anda bisa menggunakan kain penutup jika merasa tidak nyaman."
  },
  {
    "question": "8. Kapan waktu yang tepat untuk mulai menyusui?",
    "answer": "Waktu yang tepat untuk mulai menyusui adalah segera setelah bayi lahir, biasanya dalam satu jam pertama."
  },
  {
    "question": "9. Apakah ada makanan yang harus dihindari saat menyusui?",
    "answer": "Beberapa makanan seperti kafein dan alkohol sebaiknya dibatasi, karena dapat mempengaruhi ASI."
  },
  {
    "question": "10. Berapa banyak ASI yang dibutuhkan bayi?",
    "answer": "Bayi baru lahir biasanya membutuhkan sekitar 60-90 ml ASI per sesi, dan jumlah ini akan meningkat seiring pertumbuhan."
  },
  {
    "question": "11. Apakah menyusui dapat mencegah kehamilan?",
    "answer": "Menyusui eksklusif dapat menunda ovulasi, tetapi tidak dapat dijadikan metode kontrasepsi yang andal."
  },
  {
    "question": "12. Bagaimana cara menyimpan ASI perah?",
    "answer": "ASI perah dapat disimpan dalam wadah bersih di kulkas selama 3-5 hari atau di freezer hingga 6 bulan."
  },
  {
    "question": "13. Apakah bayi yang disusui lebih sehat?",
    "answer": "Bayi yang disusui cenderung memiliki sistem kekebalan yang lebih baik dan risiko penyakit yang lebih rendah."
  },
  {
    "question": "14. Kapan sebaiknya mulai memberikan makanan padat?",
    "answer": "Makanan padat sebaiknya diberikan setelah bayi berusia 6 bulan, sambil tetap menyusui."
  },
  {
    "question": "15. Apakah bisa menyusui setelah operasi payudara?",
    "answer": "Bergantung pada jenis operasi, banyak wanita masih bisa menyusui. Konsultasikan dengan dokter untuk informasi lebih lanjut."
  },
  {
    "question": "16. Apa yang harus dilakukan jika puting susu lecet?",
    "answer": "Gunakan krim khusus untuk puting susu dan pastikan teknik menyusui yang benar untuk mencegah lecet."
  },
  {
    "question": "17. Apakah menyusui dapat menyebabkan berat badan turun?",
    "answer": "Ya, menyusui dapat membantu membakar kalori dan mendukung penurunan berat badan pasca melahirkan."
  },
  {
    "question": "18. Bagaimana cara mengetahui jika bayi mendapatkan cukup ASI?",
    "answer": "Perhatikan tanda seperti bayi buang air kecil 6-8 kali sehari dan berat badan yang meningkat."
  },
  {
    "question": "19. Apakah ada risiko alergi dari ASI?",
    "answer": "Risiko alergi dari ASI sangat rendah, tetapi jika ada riwayat alergi dalam keluarga, konsultasikan dengan dokter."
  },
  {
    "question": "20. Kapan sebaiknya berhenti menyusui?",
    "answer": "Organisasi Kesehatan Dunia merekomendasikan menyusui hingga usia 2 tahun atau lebih, sesuai kebutuhan bayi."
  },
  {
    "question": "21. Apakah menyusui dapat mempengaruhi kesehatan mental ibu?",
    "answer": "Menyusui dapat memberikan rasa kedekatan dan kepuasan, tetapi juga bisa menimbulkan stres. Dukungan sosial sangat penting."
  },
  {
    "question": "22. Bagaimana cara mengatasi ASI yang berlebih?",
    "answer": "Jika mengalami ASI berlebih, Anda bisa memerah sedikit ASI sebelum menyusui untuk mengurangi tekanan."
  },
  {
    "question": "23. Apakah menyusui dapat menyebabkan masalah gigi pada bayi?",
    "answer": "Menyusui tidak menyebabkan masalah gigi, tetapi penting untuk menjaga kebersihan mulut bayi."
  },
  {
    "question": "24. Apakah bisa menyusui saat hamil?",
    "answer": "Ya, banyak ibu yang bisa menyusui saat hamil, tetapi konsultasikan dengan dokter untuk memastikan kesehatan ibu dan bayi."
  },
  {
    "question": "25. Apa yang harus dilakukan jika bayi tersedak saat menyusui?",
    "answer": "Segera hentikan menyusui dan bantu bayi untuk bernafas dengan cara mengangkatnya dan menepuk punggungnya."
  },
  {
    "question": "26. Apakah menyusui dapat mempengaruhi siklus menstruasi?",
    "answer": "Menyusui dapat menunda kembalinya siklus menstruasi, tetapi setiap wanita berbeda."
  },
  {
    "question": "27. Bagaimana cara mengatasi bayi yang sering menyusu?",
    "answer": "Bayi yang sering menyusu mungkin sedang mengalami fase pertumbuhan. Pastikan untuk tetap tenang dan menyusui sesuai permintaan."
  },
  {
    "question": "28. Apakah ada efek samping dari menyusui?",
    "answer": "Beberapa ibu mungkin mengalami nyeri puting atau mastitis, tetapi ini bisa diatasi dengan teknik menyusui yang benar."
  },
  {
    "question": "29. Kapan sebaiknya mulai menyusui kembali setelah melahirkan?",
    "answer": "Sebaiknya mulai menyusui dalam satu jam setelah melahirkan untuk membantu proses bonding."
  },
  {
    "question": "30. Apakah menyusui dapat membantu mengurangi risiko kanker payudara?",
    "answer": "Ya, beberapa penelitian menunjukkan bahwa menyusui dapat mengurangi risiko kanker payudara pada ibu."
  },
];
