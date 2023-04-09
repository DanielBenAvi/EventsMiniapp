import 'package:flutter/material.dart';

class MarketplaceHome extends StatefulWidget {
  const MarketplaceHome({Key? key}) : super(key: key);

  @override
  State<MarketplaceHome> createState() => _MarketplaceHomeState();
}

class _MarketplaceHomeState extends State<MarketplaceHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Marketplace'),
    );
  }
}
