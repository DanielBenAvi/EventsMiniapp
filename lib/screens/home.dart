import 'package:flutter/material.dart';
import 'package:social_hive_client/model/event.dart';

// demo list of events
final List<Event> events = <Event>[
  Event(
    name: 'Dance Party',
    description: 'Dance party with DJ',
    location: 'Bucharest',
    date: '2021-10-10',
    time: '20:00',
  ),
  Event(
    name: 'Ski',
    description: 'Ski in the mountains',
    location: 'Busteni',
    date: '2021-12-10',
    time: '08:00',
  ),
  Event(
    name: 'Hiking',
    description: 'Hiking in the mountains',
    location: 'Bucegi',
    date: '2021-11-10',
    time: '08:00',
  ),
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
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
                  onTap: () {},
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
        onPressed: () {},
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
