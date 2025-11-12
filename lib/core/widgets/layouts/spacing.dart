import 'package:flutter/material.dart';

/// Widget untuk vertical/horizontal spacing, lebih readable daripada SizedBox manual
class Spacing extends StatelessWidget {
  final double width;
  final double height;

  const Spacing({super.key, this.width = 0, this.height = 0});

  /// Vertical spacing helper
  factory Spacing.vertical(double height) => Spacing(height: height);

  /// Horizontal spacing helper
  factory Spacing.horizontal(double width) => Spacing(width: width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
