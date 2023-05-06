import 'package:flutter/material.dart';

class Snack extends StatelessWidget {
  const Snack({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // create SnackBar
    final Sn = SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    return Sn;
  }
}
