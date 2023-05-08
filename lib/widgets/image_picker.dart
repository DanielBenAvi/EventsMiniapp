import 'package:flutter/material.dart';
import 'package:social_hive_client/constants/avatars.dart';
import 'package:social_hive_client/widgets/avatar_item.dart';

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: Avatars().avatars.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkResponse(
                  onTap: () {
                    Navigator.pop(context, Avatars().avatars[index]);
                  },
                  child: AvatarItem(
                    photoUrl: Avatars().avatars[index],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
