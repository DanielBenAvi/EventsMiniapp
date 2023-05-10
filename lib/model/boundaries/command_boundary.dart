import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/boundaries/user_boundary.dart';

class CommandBoundary {
  CommandId commandId;
  String commnad;
  TargetObject targetObject;
  DateTime invocationTimestamp;
  InvokedBy invokedBy;
  Map<String, dynamic> commandAttributes;

  CommandBoundary({
    required this.commandId,
    required this.commnad,
    required this.targetObject,
    required this.invocationTimestamp,
    required this.invokedBy,
    required this.commandAttributes,
  });

  // fromJson
  CommandBoundary.fromJson(Map<String, dynamic> json)
      : commandId = CommandId.fromJson(json['commandId']),
        commnad = json['commnad'],
        targetObject = TargetObject.fromJson(json['targetObject']),
        invocationTimestamp = DateTime.parse(json['invocationTimestamp']),
        invokedBy = InvokedBy.fromJson(json['invokedBy']),
        commandAttributes = json['commandAttributes'];

  // toJson
  Map<String, dynamic> toJson() => {
        'commandId': commandId.toJson(),
        'commnad': commnad,
        'targetObject': targetObject.toJson(),
        'invocationTimestamp': invocationTimestamp.toIso8601String(),
        'invokedBy': invokedBy.toJson(),
        'commandAttributes': commandAttributes,
      };
}

class CommandId {
  String superapp;
  String miniapp;
  String internalCommandId;

  CommandId({
    required this.superapp,
    required this.miniapp,
    required this.internalCommandId,
  });

  // fromJson
  CommandId.fromJson(Map<String, dynamic> json)
      : superapp = json['superapp'],
        miniapp = json['miniapp'],
        internalCommandId = json['internalCommandId'];

  // toJson
  Map<String, dynamic> toJson() => {
        'superapp': superapp,
        'miniapp': miniapp,
        'internalCommandId': internalCommandId,
      };
}

class TargetObject {
  ObjectId objectId;

  TargetObject({required this.objectId});

  // fromJson
  TargetObject.fromJson(Map<String, dynamic> json)
      : objectId = ObjectId.fromJson(json['objectId']);

  // toJson
  Map<String, dynamic> toJson() => {
        'objectId': objectId.toJson(),
      };
}

class InvokedBy {
  UserId userId;

  InvokedBy({required this.userId});

  // fromJson
  InvokedBy.fromJson(Map<String, dynamic> json)
      : userId = UserId.fromJson(json['userId']);

  // toJson
  Map<String, dynamic> toJson() => {
        'userId': userId.toJson(),
      };
}
