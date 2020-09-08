import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:permission_handler/permission_handler.dart';
//import 'package:push_notification_permissions/push_notification_permissions.dart';


class UserApi{
  Client client = Client();
  final _phpUrlUserData = ''; // TODO: add php url

Future<void> setUserData(String name, String email, String phone, String city, String userId) async {
  //final response =
  await client.post(_phpUrlUserData,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'phone': phone,
      'city': city,
      'uid': userId
    }),);
  }

  Future<void> changePush(String userId, bool isPushEnabled) async{
    //final response =
    await client.post(_phpUrlUserData,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': userId,
        'push': isPushEnabled.toString()
      }),);
  }

  Future<bool> checkPushPermission() async{
  var permission = await Permission.notification.status;
    if(permission == PermissionStatus.granted)
      {
        return true;
      }
   else
     {
      return false;
     }

  }

  Future<void> askPushPermission() async{
    await Permission.notification.request();
  }
}