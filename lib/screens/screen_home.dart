import 'package:flutter/material.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/event.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/rest_api/object_api.dart';
import 'package:social_hive_client/rest_api/user_api.dart';
import 'package:social_hive_client/screens/screen_event_details.dart';

// demo list of events
final List<EventObject> events = <EventObject>[];

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  SingletonUser singletonUser = SingletonUser.instance;

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
        title: const Text('Events to Attend'),
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                _profileScreen(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_available),
              title: const Text('My Events'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/my_events');
              },
            ),
            ListTile(
              leading: const Icon(Icons.explore_outlined),
              title: const Text('Explore Events'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/explore_events');
              },
            ),
            ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  _loginScreen(context);
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_event');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _refreshData() async {
    // get list of ObjectBoundary from server
    List<ObjectBoundary> objectBoundaries = await ObjectApi().getAllObjects();

    if (objectBoundaries.isEmpty) {
      return;
    }

    // remove all type != event
    objectBoundaries.removeWhere((element) => element.type != 'EVENT');

    // remove all events that are not in the future
    objectBoundaries.removeWhere((element) =>
        DateTime.parse(element.objectDetails['date']).isBefore(DateTime.now()));

    // update events list
    setState(() {
      // convert ObjectBoundary to EventObject
      events.clear();
      for (var element in objectBoundaries) {
        events.add(EventObject.fromJson(element.objectDetails));
      }
    });
  }

  void _profileScreen(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  void _loginScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
  }
}
