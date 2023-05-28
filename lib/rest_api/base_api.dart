import 'package:social_hive_client/model/singleton_user.dart';

class BaseApi {
  final host = "localhost"; // todo: change to your IP address if changed wifi
  final portNumber = "8084";
  SingletonUser user = SingletonUser.instance;
  final String superApp = "2023b.LiorAriely";
  final String demoObjectInternalObjectId =
      "b56c29d1-f7b9-4cb9-8855-ed71d84585d2"; // todo: change to your object id when start the app
}
