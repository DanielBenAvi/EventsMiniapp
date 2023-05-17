import 'package:flutter/material.dart';
import 'package:social_hive_client/model/event.dart';
import 'package:social_hive_client/model/singleton_user.dart';

import '../model/boundaries/object_boundary.dart';
import '../rest_api/object_api.dart';
import '../rest_api/user_api.dart';
import 'screen_event_details.dart';

class ScreenMyEvents extends StatefulWidget {
  const ScreenMyEvents({Key? key}) : super(key: key);

  @override
  State<ScreenMyEvents> createState() => _ScreenMyEventsState();
}

class _ScreenMyEventsState extends State<ScreenMyEvents> {
  SingletonUser singletonUser = SingletonUser.instance;
  final List<EventObject> events = <EventObject>[];

  @override
  void initState() {
    super.initState();
    UserApi().updateRole('MINIAPP_USER');
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Events'),
        actions: [
          IconButton(
            onPressed: () {
              _refreshData();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(events[index].name),
                subtitle: Text(events[index].description),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ScreenEventDetails(event: events[index])));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    // get list of ObjectBoundary from server
    List<ObjectBoundary> objectBoundaries = await ObjectApi().getAllObjects();

    // remove all type != event
    objectBoundaries.removeWhere((element) => element.type != 'EVENT');

    // remove all events that are not in the future
    objectBoundaries.removeWhere((element) =>
        DateTime.parse(element.objectDetails['date']).isBefore(DateTime.now()));

    // remove all events that are not mine
    objectBoundaries.removeWhere(
        (element) => element.createdBy.userId.email != singletonUser.email);

    // print all objects
    for (var element in objectBoundaries) {
      debugPrint(element.toJson().toString());
    }

    // update events list
    setState(() {
      // convert ObjectBoundary to EventObject
      events.clear();
      for (var element in objectBoundaries) {
        events.add(EventObject.fromJson(element.objectDetails));
      }
    });
  }
}
