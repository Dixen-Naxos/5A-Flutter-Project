import 'package:flutter/material.dart';
import 'dart:math' as math;

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Transform.rotate(
        angle: _getRotation(id), //  90 degrees converted to radians
        child: Image.asset("assets/images/separator${_getNakanoId(id)}.png",
            fit: BoxFit.contain),
      ),
    );
  }
  double _getRotation(int id) {
    return id % 2 == 0 ? math.pi / 2 : -(math.pi / 2);
  }
  
  int _getNakanoId(int id) {
    return id % 5 + 1;
  }
}
