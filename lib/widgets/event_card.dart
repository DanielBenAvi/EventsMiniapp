import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/boundaries/object_boundary.dart';
import '../screens/screen_event_details.dart';

class EventCard extends StatelessWidget {
  final ObjectBoundary objectBoundary;

  // constructor
  const EventCard({Key? key, required this.objectBoundary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime millisecondsSinceEpoch = DateTime.fromMillisecondsSinceEpoch(
        objectBoundary.objectDetails['date']);

    String formattedDateTime =
        DateFormat('dd.MM.yyyy HH:mm').format(millisecondsSinceEpoch);
    return Card(
      child: ListTile(
        title: Text(objectBoundary.objectDetails['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formattedDateTime),
            Text(objectBoundary.objectDetails['description']),
            Text(objectBoundary.objectDetails['location']),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ScreenEventDetails(objectBoundary: objectBoundary)));
        },
      ),
    );
  }
}
