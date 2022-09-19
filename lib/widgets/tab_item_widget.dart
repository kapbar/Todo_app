import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  final String title;
  const TabItemWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: const BorderRadius.all(Radius.circular(9)),
      ),
      child: Center(
        child: Text(title),
      ),
    );
  }
}