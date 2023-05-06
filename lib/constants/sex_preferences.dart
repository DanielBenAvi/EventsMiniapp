import 'package:flutter/material.dart';
import 'package:social_hive_client/model/item_object.dart';

class SexPreferences {
  List<ItemObject> genderList = <ItemObject>[
    ItemObject(id: 1, name: 'Male'),
    ItemObject(id: 2, name: 'Female'),
    ItemObject(id: 3, name: 'Other'),
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

  List<ItemObject> getPreferences() {
    return genderList;
  }
}
