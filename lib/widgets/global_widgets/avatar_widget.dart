import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.id,
    required this.size,
  });

  final int id;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size/2,
      backgroundImage: AssetImage(
        'assets/images/nakano${_getNakanoId(id)}.png',
      ),
    );
  }

  int _getNakanoId(int id) {
    return id % 5 + 1;
  }
}
