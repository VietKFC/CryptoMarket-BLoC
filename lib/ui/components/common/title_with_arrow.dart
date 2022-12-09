import 'package:flutter/material.dart';

class TitleWithArrow extends StatelessWidget {
  final onPressed;
  final String title;
  final Color colorArrow;

  const TitleWithArrow({required this.onPressed, required this.title, required this.colorArrow, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: colorArrow,
            )
          ],
        ),
      ),
    );
  }
}
