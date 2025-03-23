import 'package:flutter/material.dart';
import 'dart:js' as js;

class MainScreenButtons extends StatelessWidget {
  const MainScreenButtons({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(
            "Életképek",
            'assets/images/mayer_logo.png',
            'https://mayerneptancmuhely.hu/album/eletkepek',
            screenWidth
        ),
        const SizedBox(height: 20),

        _buildButton(
            "Tavaszi frissesség",
            'assets/images/operavilag_logo.png',
            'https://operavilag.net/kiemelt/tavaszi-frissesseg/',
            screenWidth
        ),
        const SizedBox(height: 20),

        _buildButton(
            "A zene komikuma",
            'assets/images/operavilag_logo.png',
            'https://operavilag.net/kiemelt/a-zene-komikuma/',
            screenWidth
        ),
        const SizedBox(height: 20),

        _buildButton(
            "ViláGomba képtár",
            'assets/images/vilagomba_logo.png',
            'https://vilagombafeszt.hu/#Keptar',
            screenWidth
        ),
      ],
    );
  }

  Widget _buildButton(String text, String logoPath, String newTabUrl, double screenWidth) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          js.context.callMethod('open', [newTabUrl]);
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: screenWidth * 0.7, // Set button width to 70% of screen width
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(logoPath),
                        )
                    ),

                    const SizedBox(width: 10.0,),

                    Expanded(
                      flex: 9,
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
