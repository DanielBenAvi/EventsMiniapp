import 'package:flutter/material.dart';

class EventsHome extends StatefulWidget {
  const EventsHome({Key? key}) : super(key: key);

  @override
  State<EventsHome> createState() => _EventsHomeState();
}

class _EventsHomeState extends State<EventsHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Events'),
    );
  }
}
