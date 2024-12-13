import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngopeeh/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 550,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/BG.png'),
                  ),
                ),
              ),
              Text(
                'Ngopeeh &\nJajan ',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.bold, color: primary),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'NGOPEEH & JAJAN can \nchange your morning mood!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff687A79)),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                  width: 260,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: primary),
                    onPressed: () {},
                    child: Text(
                      "PESAN DISINI, BRO!",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white),
                    ),
                  ))
            ],
          ),
        ));
  }
}
