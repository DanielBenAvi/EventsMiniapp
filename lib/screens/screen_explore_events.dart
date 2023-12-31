import 'package:flutter/material.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/singleton_user.dart';

import '../rest_api/command_api.dart';
import '../rest_api/user_api.dart';
import 'screen_event_details.dart';

class ScreenExploreEvents extends StatefulWidget {
  const ScreenExploreEvents({Key? key}) : super(key: key);

  @override
  State<ScreenExploreEvents> createState() => _ScreenExploreEventsState();
}

class _ScreenExploreEventsState extends State<ScreenExploreEvents> {
  SingletonUser singletonUser = SingletonUser.instance;
  final List<ObjectBoundary> events = <ObjectBoundary>[];

  @override
  void initState() {
    super.initState();
    updateRole();
    _refreshData();
  }

  Future updateRole() async {
    await UserApi().updateRole('MINIAPP_USER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Events'),
        actions: [
          IconButton(onPressed: _refreshData, icon: const Icon(Icons.refresh)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _search,
        child: const Icon(Icons.search),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: events.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: events.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title:
                          Text(events[index].objectDetails['name'] as String),
                      subtitle: Text(
                          events[index].objectDetails['description'] as String),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenEventDetails(
                                objectBoundary: events[index])));
                      },
                    ),
                  );
                },
              )
            : const Center(child: Text('No new events found')),
      ),
    );
  }

  Future<void> _refreshData() async {
    //todo: remove all events that do not match the user's interests
    events.clear();

    await CommandApi().getAllEventBasedOnPeferences().then((value) {
      setState(() {
        events.addAll(value);
      });
    });
  }

  Future<void> _search() async {
    Navigator.pushNamed(context, '/search');
  }
}
