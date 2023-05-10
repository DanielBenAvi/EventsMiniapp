import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';

import '../model/item_object.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<ItemObject> _selectedPreferences = [];

  final _eventNameKey = GlobalKey<FormFieldState<String>>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: FormBuilder(
            child: Column(
              children: [
                FormBuilderTextField(
                  key: _eventNameKey,
                  autovalidateMode: AutovalidateMode.always,
                  name: 'Event Name',
                  decoration: const InputDecoration(
                    icon: Icon(Icons.event),
                    labelText: 'Event Name',
                  ),
                  validator: ValidationBuilder().maxLength(50).build(),
                ),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: 'Date',
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialValue: DateTime.now(),
                  firstDate: DateTime.now(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Date',
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'Contact Number',
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Contact Number',
                  ),
                  validator: ValidationBuilder().phone().maxLength(50).build(),
                ),
                const SizedBox(height: 20),
                MultiSelect(
                    'Prefrences', 'Prefrences', Preferences().getPreferences(),
                    onMultiSelectConfirm: (List<ItemObject> results) {
                  _selectedPreferences = results;
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _createEvent,
                  child: const Text('Create Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createEvent() {
    // TODO: Implement this method
  }
}
