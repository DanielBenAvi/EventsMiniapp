import 'package:flutter/material.dart';
import 'package:social_hive_client/model/event.dart';

class ScreenEventDetails extends StatelessWidget {
  const ScreenEventDetails({super.key, required this.event});

  final EventObject event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(event.image),
            const SizedBox(height: 20),
            Text(
              event.description,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              event.location.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              event.date.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text('Event Preferences: ${event.preferences.toString()}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                )),
            const SizedBox(height: 20),
            const Text(
              'Attendees:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: event.attendees.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  event.attendees.elementAt(index),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
