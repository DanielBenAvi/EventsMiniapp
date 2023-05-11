import 'item_object.dart';

class UserDetails {
  // constructor
  String? email;
  String? name;
  String? phoneNumber;
  List<ItemObject>? interests;
  String? gender;
  List<ItemObject>? genderPreferences;

  static UserDetails? _instance;

  UserDetails._internal();

  static UserDetails get instance {
    _instance ??= UserDetails._internal();
    return _instance!;
  }

  set sexPreferences(List<ItemObject> sexPreferences) {}

  set preferences(List<ItemObject> preferences) {}

  // toString
  @override
  String toString() {
    return 'email: $email\nname: $name\nphone: $phoneNumber\n interests: $interests\ngender: $gender\ngenderPreferences: $genderPreferences';
  }

  // fromJson
  UserDetails.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        phoneNumber = json['phoneNumber'],
        interests = json['interests'],
        gender = json['gender'],
        genderPreferences = json['genderPreferences'];

  // toJson
  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'phoneNumber': phoneNumber,
        'intersts': interests,
        'gender': gender,
        'genderPreferences': genderPreferences
      };
}
