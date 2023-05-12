import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/event.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/rest_api/object_api.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';

import '../model/item_object.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<ItemObject> _selectedPreferences = [];
  final TextEditingController _textFieldControllerName =
      TextEditingController();
  final TextEditingController _textFieldControllerContact =
      TextEditingController();
  final TextEditingController _textFieldControllerDescription =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _textFieldControllerName,
                  decoration: const InputDecoration(
                    labelText: 'Event Name',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ValidationBuilder().maxLength(50).build(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _textFieldControllerContact,
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: ValidationBuilder().phone().maxLength(50).build(),
                ),
                const SizedBox(height: 20),
                MultiSelect('Preferences', 'Preferences',
                    Preferences().getPreferences(),
                    onMultiSelectConfirm: (List<ItemObject> results) {
                  _selectedPreferences = results;
                }),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () {
                      pickDateTime();
                    },
                    child: Text(
                      '${dateTime.day}/${dateTime.month}/${dateTime.year} $hours:$minutes',
                    )),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _textFieldControllerDescription,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  minLines: 3,
                  // Set this
                  maxLines: 6,
                  //
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: ValidationBuilder().build(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: _addLocation,
                    child: const Text('Choose Location')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createEvent();
                      // move to home screen
                      _screenHome();
                    } else {
                      debugPrint('Form is invalid');
                    }
                  },
                  child: const Text('Create Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return; // user pressed cancel

    TimeOfDay? time = await pickTime();
    if (time == null) return; // user pressed cancel

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => this.dateTime = dateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(dateTime),
      );

  void _createEvent() {
    // add loading circle
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // create event
    debugPrint('\n - Create Event');
    SingletonUser userDetails = SingletonUser.instance;
    Event event = Event(
      name: _textFieldControllerName.text,
      contact: _textFieldControllerContact.text,
      description: _textFieldControllerDescription.text,
      preferences: _getMapFromList(_selectedPreferences),
      location: Location(
        lat: 10.2,
        lng: 10.2,
      ),
      image:
          'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg',
      attendees: {},
      date: dateTime,
    );

    // post event
    ObjectBoundary objectBoundary = ObjectBoundary(
      objectId: ObjectId('2023b.LiorAriely', ""),
      type: 'EVENT',
      alias: 'Event',
      active: true,
      creationTimestamp: DateTime.now(),
      location: event.location,
      createdBy: userDetails.createdBy,
      objectDetails: event.toJson(),
    );

    ObjectApi().postObject(objectBoundary);
  }

  Map<String, dynamic> _getMapFromList(List<ItemObject> list) {
    Map<String, String> map = {};
    int i = 0;
    for (ItemObject item in list) {
      map[i.toString()] = item.name;
      i++;
    }
    debugPrint('map:$map');
    return map;
  }

  void _screenHome() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/home');
  }

  void _addLocation() {
    Navigator.pushNamed(context, '/choose_location');
  }
}
