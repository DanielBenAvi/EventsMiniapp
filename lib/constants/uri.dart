import 'package:social_hive_client/model/user.dart';


class Url{
  String appTitle = '2023b.LiorAriely';
  String? login;

  static final Url _instance = Url._internal();


  factory Url() {
    _instance.login = 'http://localhost:8084/superapp/users/login/2023b.LiorAriely/';
    return _instance;
  }

  Url._internal();

  // getters
  String getAppTitle() => appTitle;
  String? getUser() => login;
}
