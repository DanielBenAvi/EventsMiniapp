import 'package:flutter/material.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';

class ScreenEventDetails extends StatelessWidget {
  const ScreenEventDetails({super.key, required this.objectBoundary});

  final ObjectBoundary objectBoundary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(objectBoundary.objectDetails['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(objectBoundary.objectDetails['image']),
            const SizedBox(height: 20),
            Text(
              objectBoundary.objectDetails['name'],
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              objectBoundary.location.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              objectBoundary.objectDetails['date'].toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
                'Event Preferences: ${objectBoundary.objectDetails['preferences'].toString()}',
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
              itemCount: objectBoundary.objectDetails['attendees'].length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  objectBoundary.objectDetails['attendees'].elementAt(index),
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
