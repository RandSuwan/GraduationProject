import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sizeslider extends StatelessWidget {
  final Widget child;
  const sizeslider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
      const double thumbRadius = 14;
    const double tickMarkRadius = 8;

    final activeColor = Color.fromRGBO(255, 0, 77, 1);
    final inactiveColor = Color.fromRGBO(109, 114, 120, 1);

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 5,

        /// Thumb
        thumbShape: RoundSliderThumbShape(
          disabledThumbRadius: thumbRadius,
          enabledThumbRadius: thumbRadius,
        ),
        rangeThumbShape: RoundRangeSliderThumbShape(
          disabledThumbRadius: thumbRadius,
          enabledThumbRadius: thumbRadius,
        ),

        /// Tick Mark
        tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: tickMarkRadius),

        /// Inactive
        inactiveTickMarkColor: inactiveColor,
        inactiveTrackColor: inactiveColor,

        /// Active
        thumbColor: activeColor,
        activeTrackColor: activeColor,
        activeTickMarkColor: activeColor,
      ),
      child: child,
    );
  
  }
}