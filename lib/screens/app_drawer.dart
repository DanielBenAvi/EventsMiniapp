import 'package:flutter/material.dart';
import 'package:social_hive_client/screens/dating_home.dart';
import 'package:social_hive_client/screens/groups_home.dart';
import 'package:social_hive_client/screens/home.dart';
import 'package:social_hive_client/screens/marketplace_home.dart';
import 'package:social_hive_client/screens/events_home.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int currentPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.heart_broken),
            label: 'Dating',
          ),
          NavigationDestination(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Marketplace',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const DatingHome(),
        ),
        Container(
          alignment: Alignment.center,
          child: const EventsHome(),
        ),
        Container(
          alignment: Alignment.center,
          child: const Home(),
        ),      Container(
          alignment: Alignment.center,
          child: const GroupsHome(),
        ),      Container(
          alignment: Alignment.center,
          child: const MarketplaceHome(),
        ),
      ][currentPageIndex],
    );
  }
}
