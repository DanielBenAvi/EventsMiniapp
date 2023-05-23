import 'package:social_hive_client/model/singleton_user.dart';

class BaseApi {
  final host =
      "192.168.1.107"; // todo: change to your IP address if changed wifi
  final portNumber = "8084";
  SingletonUser user = SingletonUser.instance;
  final String superApp = "2023b.LiorAriely";
}
