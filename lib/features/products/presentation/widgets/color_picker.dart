import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });

  final List<Color> colors;
  final Function(Color) onColorSelected;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32, // Increased slightly to fit border
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final Color color = widget.colors[index];
          final bool isSelected = _selectedIndex == index;

          // 1. Determine if the color is Light or Dark
          // This helps us decide if the Check Icon should be Black or White
          final bool isLightColor =
              ThemeData.estimateBrightnessForColor(color) == Brightness.light;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onColorSelected(color);
            },
            // FIX: Use Container instead of CircleAvatar for better border control
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                // 2. Add a border so White/Black colors don't blend into the background
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade600 // Border for Dark Mode
                      : Colors.grey.shade300, // Border for Light Mode
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Icon(
                Icons.check,
                size: 18,
                // 3. Adaptive Icon Color (White on Dark, Black on Light)
                color: isLightColor ? Colors.black : Colors.white,
              )
                  : null,
            ),
          );
        },
      ),
    );
  }
}