import 'package:flutter/material.dart';
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/item_object.dart';
import 'package:social_hive_client/rest_api/command_api.dart';
import 'package:social_hive_client/rest_api/user_api.dart';
import 'package:social_hive_client/screens/screen_event_details.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';

enum Sreach { name, dates, preference }

class ScreenSearchPage extends StatefulWidget {
  const ScreenSearchPage({super.key});

  @override
  State<ScreenSearchPage> createState() => _ScreenSearchPageState();
}

class _ScreenSearchPageState extends State<ScreenSearchPage> {
  final _textFieldControllerSearch = TextEditingController();
  final List<ObjectBoundary> events = <ObjectBoundary>[];
  List<ItemObject> _selectedPreferences = [];

  Sreach searchView = Sreach.name;

  @override
  void initState() {
    super.initState();
    UserApi().updateRole('MINIAPP_USER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            multiSelect(),
            const SizedBox(height: 20),
            optionSearch(),
            // radio button with the options to search by name, date, preference
            const SizedBox(height: 20),
            listview(),
          ],
        ),
      ),
    );
  }

  Widget optionSearch() {
    return searchView == Sreach.name
        ? TextField(
            controller: _textFieldControllerSearch,
            onChanged: (value) {
              if (_textFieldControllerSearch.text.isNotEmpty) {
                _search(_textFieldControllerSearch.text);
              } else {
                setState(() {
                  events.clear();
                });
              }
            },
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          )
        : searchView == Sreach.dates
            ? OutlinedButton(
                onPressed: () {
                  _search(_textFieldControllerSearch.text);
                },
                child: const Text('Choose dates'),
              )
            : MultiSelect(
                "Preferences",
                "Preferences",
                Preferences().getPreferences(),
                onMultiSelectConfirm: (List<ItemObject> results) {
                  _selectedPreferences = results;
                },
              );
  }

  Widget listview() {
    return events.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(events[index].objectDetails['name'] as String),
                  subtitle: Text(
                      events[index].objectDetails['description'] as String),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ScreenEventDetails(objectBoundary: events[index])));
                  },
                ),
              );
            },
          )
        : const Center(child: Text('No new events found'));
  }

  Widget multiSelect() {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<Sreach>(
        segments: const <ButtonSegment<Sreach>>[
          ButtonSegment<Sreach>(
              value: Sreach.name, label: Text('Name'), icon: Icon(Icons.event)),
          ButtonSegment<Sreach>(
              value: Sreach.dates,
              label: Text('Dates'),
              icon: Icon(Icons.date_range)),
          ButtonSegment<Sreach>(
              value: Sreach.preference,
              label: Text('Preference'),
              icon: Icon(Icons.favorite)),
        ],
        selected: <Sreach>{searchView},
        onSelectionChanged: (Set<Sreach> newSelection) {
          setState(() {
            searchView = newSelection.first;
          });
        },
      ),
    );
  }

  Future _search(String value) async {
    events.clear();
    switch (searchView) {
      case Sreach.name:
        await _searchByName(value);
        break;

      case Sreach.dates:
        await _searchByDate(value);
        break;
      case Sreach.preference:
        await _searchByPreference(value);
        break;
    }
  }

  Future<void> _searchByName(String value) async {
    await CommandApi().searchByName(value).then((value) {
      setState(() {
        events.addAll(value);
      });
    });
  }

  Future<void> _searchByPreference(String value) async {
    // TODO: implement _searchByPreference
    // TODO: change the search by preference to get list of preferences
  }

  Future<void> _searchByDate(String value) async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(), // the earliest allowable
      lastDate: DateTime(2030, 12, 31), // the latest allowable
      currentDate: DateTime.now(),
      saveText: 'Done',
    );
    int start = result?.start.millisecondsSinceEpoch as int;
    int end = result?.end.millisecondsSinceEpoch as int;
    await CommandApi().searchByDates(start, end).then((value) {
      setState(() {
        events.addAll(value);
      });
    });
  }
}
