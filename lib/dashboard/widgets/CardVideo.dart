import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardVideo extends StatelessWidget {
  final String description;
  final String image;
  final String url;

  const CardVideo(
      {Key? key,
      required this.description,
      required this.image,
      required this.url})
      : super(key: key);

  void _launchURL() async {
    // Format URL untuk membuka aplikasi YouTube
    String modifiedUrl = "vnd.youtube:${url.split('://').last}";

    final Uri androidUrl = Uri.parse(modifiedUrl);
    final Uri fallbackUrl =
        Uri.parse("https://www.youtube.com/watch?v=${url.split('://').last}");

    print('Trying to launch: $androidUrl');

    // Coba membuka di aplikasi YouTube
    if (await canLaunchUrl(androidUrl)) {
      await launchUrl(androidUrl, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $androidUrl, opening fallback URL: $fallbackUrl');
      // Buka di browser jika aplikasi YouTube tidak ada
      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $fallbackUrl';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _launchURL,
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Atur radius sesuai kebutuhan
                child: Image.asset(
                  image,
                  fit: BoxFit.cover, // Atur fit sesuai kebutuhan
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Fredoka',
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
