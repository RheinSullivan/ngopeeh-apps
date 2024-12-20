import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ngopeeh/screens/home_page.dart';
import 'package:ngopeeh/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://www.rheinsullivan.web.id/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: GestureDetector(
          onTap: _launchURL,
          child: const Text(
            'Rhein Sullivan \n210511020',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xffff0000),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        backgroundColor: background,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/png/icons.png'),
                ),
              ),
            ),
            Text(
              'Ngopeeh &\nNongkrongs',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Rilekskan harimu dengan cara \nNgopeeh & Nongkrongs disini!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xff687A79),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 260,
              height: 45,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: primary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Text(
                  "PESAN DISINI, BRO!",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
