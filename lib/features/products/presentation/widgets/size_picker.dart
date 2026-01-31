import 'package:flutter/material.dart';

class SizePickerWidget extends StatefulWidget {
  const SizePickerWidget({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
  });

  final List<String> sizes;
  final Function(String) onSizeSelected;

  @override
  State<SizePickerWidget> createState() => _SizePickerWidgetState();
}

class _SizePickerWidgetState extends State<SizePickerWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.sizes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool isSelected = _selectedIndex == index;
          final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onSizeSelected(widget.sizes[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                // FIX 1: Use Transparent background for unselected items
                // This lets the dark/light scaffold color show through
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,

                borderRadius: BorderRadius.circular(20),

                // FIX 2: Adaptive Border
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : isDarkMode ? Colors.grey.shade700 : Colors.grey,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                widget.sizes[index],
                style: TextStyle(
                  // FIX 3: Adaptive Text Color
                  // Selected: White
                  // Unselected (Dark Mode): White
                  // Unselected (Light Mode): Black
                  color: isSelected
                      ? Colors.white
                      : isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}