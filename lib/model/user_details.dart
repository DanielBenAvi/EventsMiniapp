class UserDetails {
  // constructor
  String? email;
  String? name;
  String? phoneNumber;
  List<String>? interests;
  String? gender;
  List<String>? genderPreferences;

  static final UserDetails _instance = UserDetails._internal();

  factory UserDetails(String email) {
    _instance.email = email;
    return _instance;
  }

  UserDetails._internal();

  // getters
  String? get getEmail => email;

  String? get getName => name;

  String? get getPhoneNumber => phoneNumber;

  List<String>? get getInterests => interests;

  String? get getGender => gender;

  List<String>? get getGenderPreferences => genderPreferences;

  // setters
  set setEmail(String? email) => this.email = email;

  set setName(String? name) => this.name = name;

  set setPhoneNumber(String? phoneNumber) => this.phoneNumber = phoneNumber;

  set setInterests(List<String>? interests) => this.interests = interests;

  set setGender(String? gender) => this.gender = gender;

  set setGenderPreferences(List<String>? genderPreferences) =>
      this.genderPreferences = genderPreferences;

// toString
  @override
  String toString() {
    return 'UserDetails{email: $email, name: $name, phoneNumber: $phoneNumber, interests: $interests, gender: $gender, genderPreferences: $genderPreferences}';
  }
}
