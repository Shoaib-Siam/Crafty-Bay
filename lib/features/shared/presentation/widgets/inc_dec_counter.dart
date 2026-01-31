import 'package:flutter/material.dart';

class IncDecCounter extends StatefulWidget {
  const IncDecCounter({
    super.key,
    this.initialValue = 1,
    this.minValue = 1,
    this.maxValue = 20,
    required this.onChange,
  });

  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChange;

  @override
  State<IncDecCounter> createState() => _IncDecCounterState();
}

class _IncDecCounterState extends State<IncDecCounter> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCounterIcon(
          icon: Icons.remove,
          onTap: () {
            if (_currentValue > widget.minValue) {
              setState(() {
                _currentValue--;
              });
              widget.onChange(_currentValue);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            // Formatting to '01', '02' etc. to match your design
            _currentValue.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildCounterIcon(
          icon: Icons.add,
          onTap: () {
            if (_currentValue < widget.maxValue) {
              setState(() {
                _currentValue++;
              });
              widget.onChange(_currentValue);
            }
          },
        ),
      ],
    );
  }

  Widget _buildCounterIcon({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}