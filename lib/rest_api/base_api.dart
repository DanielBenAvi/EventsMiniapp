import 'package:social_hive_client/model/singleton_user.dart';

class BaseApi {
  final host = "localhost"; // todo: change to your IP address if changed wifi
  final portNumber = "8084";
  SingletonUser user = SingletonUser.instance;
  final String superApp = "2023b.LiorAriely";
  final String demoObjectInternalObjectId =
      "3c14475a-f8be-44e6-8709-5af884c8106f"; // todo: change to your object id when start the app
}
