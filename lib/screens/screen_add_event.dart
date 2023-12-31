import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:social_hive_client/constants/keys.dart';
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/rest_api/object_api.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';

import '../model/item_object.dart';
import '../rest_api/user_api.dart';

class ScreenAddEvent extends StatefulWidget {
  const ScreenAddEvent({super.key});

  @override
  State<ScreenAddEvent> createState() => _ScreenAddEventState();
}

class _ScreenAddEventState extends State<ScreenAddEvent> {
  List<ItemObject> _selectedPreferences = [];
  final TextEditingController _textFieldControllerName =
      TextEditingController();
  final TextEditingController _textFieldControllerContact =
      TextEditingController();
  final TextEditingController _textFieldControllerDescription =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  );

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? downloadURL;

  @override
  void initState() {
    super.initState();
    updateRole(); // update role to SUPERAPP_USER only SuperApp_user can create objects
  }

  Future updateRole() async {
    await UserApi().updateRole(
        'SUPERAPP_USER'); // update role to SUPERAPP_USER only SuperApp_user can create objects
  }

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
                placesAutoCompleteTextField(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: _filePiker, child: const Text('Add Image')),
                    Image.network(
                      downloadURL ?? 'https://fire-center.co.il/wp-content/uploads/2021/02/placeholder.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
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

  Future _filePiker() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
    Uint8List? uploadFile = result.files.single.bytes;
    final path = 'files/${pickedFile!.name}';

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putData(uploadFile!);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      downloadURL = urlDownload;
    });
    debugPrint('Download-Link: $urlDownload');
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

    SingletonUser user = SingletonUser.instance;

    debugPrint('LOG --- Create Event');
    Map<String, dynamic> objectBoundary = {
      "objectId": {},
      "type": "EVENT",
      "alias": "event",
      "active": true,
      "location": {"lat": 10.2, "lng": 10.2},
      "createdBy": {
        "userId": {
          "superapp": "2023b.LiorAriely",
          "email": user.email,
        }
      },
      "objectDetails": {
        "name": _textFieldControllerName.text,
        "contact": _textFieldControllerContact.text,
        "location": _locationController.text,
        "image": downloadURL,
        "preferences": _getSetFromList(_selectedPreferences),
        "description": _textFieldControllerDescription.text,
        "date": dateTime.millisecondsSinceEpoch, 
        "attendees": []
      }
    };

    ObjectApi().postObjectJson(objectBoundary);

    _screenHome();
  }

  List<String> _getSetFromList(List<ItemObject> list) {
    Set<String> preferences = {};
    for (ItemObject item in list) {
      preferences.add(item.name);
    }
    return preferences.toList();
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: _locationController,
        googleAPIKey: apiKey,
        inputDecoration:
            const InputDecoration(hintText: "Search your location"),
        debounceTime: 800,
        countries: const ["il"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {},
        itmClick: (Prediction prediction) async {
          _locationController.text = prediction.description!;
          _locationController.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length));
        },
      ),
    );
  }

  void _screenHome() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/home');
  }
}
