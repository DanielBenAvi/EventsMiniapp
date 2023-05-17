import 'package:social_hive_client/model/singleton_user.dart';

class BaseApi {
  final host = "172.20.18.18";
  final portNumber = "8084";
  SingletonUser user = SingletonUser.instance;
  final String superApp = "2023b.LiorAriely";
}
