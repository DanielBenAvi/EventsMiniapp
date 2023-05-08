import 'package:flutter/material.dart';

class AvatarItem extends StatelessWidget {
  final String photoUrl;
  const AvatarItem({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(photoUrl),
    );
  }
}
