import 'package:flutter/material.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/singleton_user.dart';

import '../rest_api/command_api.dart';
import '../rest_api/user_api.dart';
import 'screen_event_details.dart';

class ScreenMyEvents extends StatefulWidget {
  const ScreenMyEvents({Key? key}) : super(key: key);

  @override
  State<ScreenMyEvents> createState() => _ScreenMyEventsState();
}

class _ScreenMyEventsState extends State<ScreenMyEvents> {
  SingletonUser singletonUser = SingletonUser.instance;
  final List<ObjectBoundary> events = <ObjectBoundary>[];

  @override
  void initState() async {
    super.initState();
    await UserApi().updateRole('MINIAPP_USER');
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
                title: Text(events[index].objectDetails['name'] as String),
                subtitle:
                    Text(events[index].objectDetails['description'] as String),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ScreenEventDetails(objectBoundary: events[index])));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    // get all events
    events.clear();

    await CommandApi().getMyEvents().then((value) {
      setState(() {
        events.addAll(value);
      });
    });
  }
}
