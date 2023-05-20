import 'package:flutter/material.dart';
import 'package:social_hive_client/model/event.dart';
import 'package:social_hive_client/model/singleton_user.dart';

import '../rest_api/user_api.dart';
import 'screen_event_details.dart';

class ScreenExploreEvents extends StatefulWidget {
  const ScreenExploreEvents({Key? key}) : super(key: key);

  @override
  State<ScreenExploreEvents> createState() => _ScreenExploreEventsState();
}

class _ScreenExploreEventsState extends State<ScreenExploreEvents> {
  SingletonUser singletonUser = SingletonUser.instance;
  final List<EventObject> events = <EventObject>[];

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
        title: const Text('Explore Events'),
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
    //todo: remove all events that do not match the user's interests
  }
}
