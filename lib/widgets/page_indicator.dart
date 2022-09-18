import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';

class PageTabIndicationPainter extends CustomPainter {
  final PageController pageController;

  PageTabIndicationPainter({required this.pageController})
      : super(repaint: pageController);

  @override
  void paint(Canvas canvas, Size size) {
    double pageOffset = 0;
   

    Paint painterIndicator = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(
                pageOffset * size.width, 0, (size.width), size.height),
            const Radius.circular(16)),
        painterIndicator);
    canvas.translate(size.width * pageOffset, 0.0);
  }

  @override
  bool shouldRepaint(PageTabIndicationPainter oldDelegate) => true;
}
