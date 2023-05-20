class UserDetails {
  // constructor
  String email;
  String name;
  String phoneNumber;
  List<String> interests;
  String gender;
  List<String> genderPreferences;

  // constructor
  UserDetails({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.interests,
    required this.gender,
    required this.genderPreferences,
  });

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
        'interests': interests,
        'gender': gender,
        'genderPreferences': genderPreferences
      };
}
