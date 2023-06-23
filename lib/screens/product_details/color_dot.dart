import 'package:flutter/material.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onColorSelected,
  }) : super(key: key);

  final Color color;
  final bool isSelected;
  final ValueChanged<Color> onColorSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onColorSelected(color);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0 / 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 2.0,
          ),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: color,
        ),
      ),
    );
  }
}
