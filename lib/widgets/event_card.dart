import 'package:flutter/material.dart';

import '../model/boundaries/object_boundary.dart';
import '../screens/screen_event_details.dart';

class EventCard extends StatelessWidget {
  final ObjectBoundary objectBoundary;

  // constructor
  const EventCard({Key? key, required this.objectBoundary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(objectBoundary.objectDetails['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateTime.parse(objectBoundary.objectDetails['date'])
                .toString()),
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
