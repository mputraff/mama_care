import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardVideo extends StatelessWidget {
  final String description;
  final String views;
  final String image;
  final String url;

  const CardVideo(
      {Key? key,
      required this.description,
      required this.views,
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
          width: 210,
          height: 195,
          decoration: new BoxDecoration(
            color: Color.fromARGB(255, 125, 159, 168),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(5), // Atur radius sesuai kebutuhan
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover, // Atur fit sesuai kebutuhan
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 5),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Fredoka',
                    color: Colors.grey[100],
                  ),
                ),
              ),
              SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  views,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Fredoka',
                    color: Colors.grey[100],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
