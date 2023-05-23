import 'package:flutter/material.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/rest_api/command_api.dart';
import 'package:social_hive_client/rest_api/user_api.dart';
import 'package:social_hive_client/widgets/event_card.dart';

import '../model/boundaries/object_boundary.dart';

// demo list of events
final List<ObjectBoundary> events = <ObjectBoundary>[];

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
            return EventCard(objectBoundary: events[index]);
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
                Navigator.pushNamed(context, '/profile');
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

  Future _refreshData() async {
    events.clear();

    await CommandApi().getMyEvents().then((value) {
      setState(() {
        events.addAll(value);
      });
    });
  }

  void _loginScreen(BuildContext context) {
    // pop all screens and go to login screen
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushNamed(context, '/login');
  }
}
