class UserDetails {
  // constructor
  String email;
  String name;
  String phoneNumber;
  List<String> preferences;
  String gender;
  List<String> genderPreferences;

  // constructor
  UserDetails({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.preferences,
    required this.gender,
    required this.genderPreferences,
  });

  // toString
  @override
  String toString() {
    return 'email: $email\nname: $name\nphone: $phoneNumber\n interests: $preferences\ngender: $gender\ngenderPreferences: $genderPreferences';
  }

  // fromJson
  UserDetails.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        phoneNumber = json['phoneNumber'],
        preferences = json['interests'],
        gender = json['gender'],
        genderPreferences = json['genderPreferences'];

  // toJson
  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'phoneNumber': phoneNumber,
        'interests': preferences,
        'gender': gender,
        'genderPreferences': genderPreferences
      };
}
