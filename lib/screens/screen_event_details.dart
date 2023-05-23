import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/singleton_user.dart';

import '../rest_api/command_api.dart';

class ScreenEventDetails extends StatelessWidget {
  const ScreenEventDetails({super.key, required this.objectBoundary});

  final ObjectBoundary objectBoundary;

  @override
  Widget build(BuildContext context) {
    SingletonUser user = SingletonUser.instance;

    DateTime millisecondsSinceEpoch = DateTime.fromMillisecondsSinceEpoch(
        objectBoundary.objectDetails['date']);

    String formattedDateTime =
        DateFormat('dd.MM.yyyy HH:mm').format(millisecondsSinceEpoch);

    String objectId = objectBoundary.objectId.internalObjectId;

    return Scaffold(
      appBar: AppBar(
        title: Text(objectBoundary.objectDetails['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
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
                objectBoundary.objectDetails['location'].toString(),
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Text(
                formattedDateTime,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: !objectBoundary.objectDetails['attendees']
                        .contains(user.email),
                    child: ElevatedButton(
                      onPressed: () {
                        _joinEvent(objectId);
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text('Join'),
                    ),
                  ),
                  Visibility(
                    visible: objectBoundary.objectDetails['attendees']
                        .contains(user.email),
                    child: ElevatedButton(
                      onPressed: () {
                        _leaveEvent(objectId);
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text('Leave'),
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }

  Future _joinEvent(objectId) async {
    await CommandApi().joinEvent(objectId);
  }

  Future _leaveEvent(objectId) async {
    await CommandApi().leaveEvent(objectId);
  }
}
