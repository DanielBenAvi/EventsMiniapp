import 'package:flutter/material.dart';

class SexPreference {
  final int id;
  final String name;

  SexPreference({
    required this.id,
    required this.name,
  });
}

class SexPreferences {
  List<SexPreference> genderList = <SexPreference>[
    SexPreference(id: 1, name: 'Male'),
    SexPreference(id: 2, name: 'Female'),
    SexPreference(id: 3, name: 'Other'),
  ];
  List<Icon> iconList = <Icon>[
    const Icon(Icons.male),
    const Icon(Icons.female),
    const Icon(IconData(0xf888, fontFamily: 'MaterialIcons')),
  ];

  static final SexPreferences _instance = SexPreferences._internal();

  factory SexPreferences() {
    return _instance;
  }

  SexPreferences._internal();

  List<SexPreference> getPreferences() {
    return genderList;
  }
}
