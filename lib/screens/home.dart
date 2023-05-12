import 'package:flutter/material.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/event.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/screens/event_details.dart';

// demo list of events
final List<Event> events = <Event>[
  Event(
    name: 'Dance Party',
    description: 'Dance party with DJ',
    location: Location(lat: 45.657975, lng: 25.601198),
    date: DateTime.parse('2023-07-20 20:18:04Z'),
    image: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819',
    attendees: {'0': 'demo@gmail.com'},
    preferences: {'0': 'Dance'},
    contact: '+972-50-1234567',
  ),
  Event(
    name: 'Ski',
    description: 'Ski in the mountains',
    location: Location(lat: 45.657975, lng: 25.601198),
    date: DateTime.parse('2023-07-20 20:18:04Z'),
// 1969-07-20
    image: 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256',
    attendees: {'0': 'demo@gmail.com'},
    preferences: {'0': 'Ski'},
    contact: '+972-50-1234567',
  ),
  Event(
    name: 'Hiking',
    description: 'Hiking in the mountains',
    location: Location(lat: 45.657975, lng: 25.601198),
    date: DateTime.parse('2023-07-20 20:18:04Z'),
    image: 'https://images.unsplash.com/photo-1551632811-561732d1e306',
    attendees: {'0': 'demo@gmail.com'},
    preferences: {'0': 'Tennis'},
    contact: '+972-50-1234567',
  ),
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SingletonUser singletonUser = SingletonUser.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(singletonUser.username ?? 'Home'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(events[index].name),
                  subtitle: Text(events[index].description),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EventDetails(event: events[index])));
                  },
                ),
                const Divider(),
              ],
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
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
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _profileScreen(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  void _loginScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
  }
}
