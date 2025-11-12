// lib/core/extensions/widget_gesture.dart
import 'package:flutter/material.dart';

extension WidgetGesture on Widget {
  Widget buildGesture({required VoidCallback onTap}) {
    return GestureDetector(onTap: onTap, child: this);
  }
}
