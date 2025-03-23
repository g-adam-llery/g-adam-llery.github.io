import 'package:flutter/material.dart';

class MainScreenButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton("Életképek", screenWidth),
        SizedBox(height: 20),
        _buildButton("Tavaszi frissesség", screenWidth),
        SizedBox(height: 20),
        _buildButton("Zene komikuma", screenWidth),
      ],
    );
  }

  Widget _buildButton(String text, double screenWidth) {
    return GestureDetector(
      onTap: () {
        // Button action
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: screenWidth * 0.7, // Set button width to 70% of screen width
        padding: EdgeInsets.symmetric(vertical: 15),
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
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
