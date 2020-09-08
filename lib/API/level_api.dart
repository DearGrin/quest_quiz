import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:quest_quiz/Models/level_model.dart';

class LevelApi{
  Client client = Client();
  final _phpUrlLevel = ''; // TODO: add php url
  final _phpSendAnswer = ""; // TODO: add php url

  Future<Level> fetchLevel() async{
    final response =
      await client.get(_phpUrlLevel);
    return Level.fromJson(json.decode(response.body));
  }

  Future<AnswerCallback> sendAnswer(String answer) async{
    final response =
    await client.post(_phpSendAnswer,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'answer': answer,
      }),);
      return AnswerCallback.fromJson(json.decode(response.body));
  }
}