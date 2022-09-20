import 'package:flutter/material.dart';

class CategoryButtonWidget extends StatelessWidget {
  const CategoryButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(0, 0)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12)),
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            '+',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(width: 7),
          Text(
            'Категория',
            style: TextStyle(
              color: Color.fromARGB(255, 66, 71, 79),
            ),
          ),
        ],
      ),
    );
  }
}