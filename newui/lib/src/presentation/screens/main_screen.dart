import 'package:flutter/material.dart';
import 'dart:math';

import 'package:newui/src/presentation/widgets/main_screen_button.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> _particles = []; // Initialize as an empty list
  late Size screenSize;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        screenSize = MediaQuery.of(context).size;
        generateParticles();
        isInitialized = true;
      });
    });
  }

  void generateParticles() {
    final random = Random();
    _particles = List.generate(20, (index) => Particle(
      position: Offset(
        random.nextDouble() * screenSize.width,
        random.nextDouble() * screenSize.height,
      ),
      velocity: Offset(
        (random.nextDouble() - 0.5) * 2, // Random speed between -1 and 1
        (random.nextDouble() - 0.5) * 2,
      ),
      size: random.nextDouble() * 2 + 0, // Random size between 2 and 5
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show loading indicator
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: BackgroundPainter(_particles, _controller.value, screenSize),
                child: Container(),
              );
            },
          ),
          Positioned(
            top: 40, // Adjust this value to your liking
            left: 20,
            right: 20,
            child: Text(
              '@g.adam.llery', // Replace with the actual photographer's name
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: MainScreenButtons()
          )
        ],
      ),
    );
  }
}

class Particle {
  Offset position;
  Offset velocity;
  double size;

  Particle({required this.position, required this.velocity, required this.size});
}

class BackgroundPainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;
  final Size screenSize;

  BackgroundPainter(this.particles, this.animationValue, this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blueGrey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    final particlePaint = Paint()..color = Colors.white.withOpacity(0.3);

    for (var particle in particles) {
      // Move each particle independently
      particle.position = Offset(
        (particle.position.dx + particle.velocity.dx) % screenSize.width,
        (particle.position.dy + particle.velocity.dy) % screenSize.height,
      );

      canvas.drawCircle(particle.position, particle.size, particlePaint);
    }

    // Add Lens Flare Effect (Gradient Circle)
    final flarePaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.orangeAccent.withOpacity(0.1), Colors.transparent],
        radius: 0.5,
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.7, size.height * 0.2),
        radius: size.width * 0.2,
      ));
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.2), size.width * 0.2, flarePaint);

    // Add Light Rays Effect
    final lightPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white.withOpacity(0.1), Colors.transparent],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), lightPaint);

    // Add Soft Moving Gradient Overlay
    final gradientOverlay = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue.withOpacity(0.1), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), gradientOverlay);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
