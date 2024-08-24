import 'package:flutter/material.dart';

class RectangleClipper extends CustomClipper<Rect> {
  final double width;
  RectangleClipper({required this.width});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return oldClipper is RectangleClipper && oldClipper.width != width;
  }
}