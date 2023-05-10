import 'package:flutter/material.dart';
import 'package:social_hive_client/model/event.dart';
import 'package:social_hive_client/model/singletone_user.dart';
import 'package:social_hive_client/widgets/event_details.dart';

// demo list of events
final List<Event> events = <Event>[
  Event(
    name: 'Dance Party',
    description: 'Dance party with DJ',
    location: 'Bucharest',
    date: '2021-10-10',
    time: '20:00',
    image: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819',
  ),
  Event(
    name: 'Ski',
    description: 'Ski in the mountains',
    location: 'Busteni',
    date: '2021-12-10',
    time: '08:00',
    image: 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256',
  ),
  Event(
    name: 'Hiking',
    description: 'Hiking in the mountains',
    location: 'Bucegi',
    date: '2021-11-10',
    time: '08:00',
    image: 'https://images.unsplash.com/photo-1551632811-561732d1e306',
  ),
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SingletoneUser singletoneUser = SingletoneUser.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(singletoneUser.username ?? 'Home'),
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
