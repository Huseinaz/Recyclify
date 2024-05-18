import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedBin extends StatelessWidget {
  final String type;
  final int percentage;
  final Color color;

  const AnimatedBin({
    super.key,
    required this.type,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 258,
            height: 327,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/image/bin.svg',
                    ),
                  ),
                ),
                ClipPath(
                  clipper: BinClipper(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: (percentage / 100) * 327,
                      width: 258,
                      color: color.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: Text(
                        '$percentage%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            type,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BinClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(3, 3);
    path.lineTo(28, 304.5);

    path.cubicTo(108.291, 329.675, 152.743, 329.326, 231, 304.5);

    path.lineTo(255, 3);
    path.lineTo(3, 3);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
