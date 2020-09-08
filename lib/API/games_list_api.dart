import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:quest_quiz/Models/games_model.dart';

class GamesListApi{
  Client client = Client();
  final _phpUrlAnons = ''; // TODO: add php url
  final _phpUrlFinished = ''; // TODO: add php url
  final _phpJoinGameByPin = ''; //TODO add php url
  final _phpJoinGameByFee = ''; //TODO add php url
  final _phpGamesByUser = ''; //TODO add php url
  final _phpUrlAnonsWithFilter =''; //TODO add php url
  final _phpUrlFinishedWithFilter =''; //TODO add php url

  Future<GamesList> fetchAnons() async {
    final response =
    await client.get(_phpUrlAnons);
    return GamesList.fromJson(json.decode(response.body));
  }
  Future<GamesList> fetchFinished() async {
    final response =
    await client.get(_phpUrlFinished);
    return GamesList.fromJson(json.decode(response.body));
  }
  Future<GamesList> fetchGamesByUser(String userId) async{
    final response =
    await client.post(_phpGamesByUser,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId' : userId
      }),);
    return GamesList.fromJson(json.decode(response.body));
  }
  Future<GamesList> fetchAnonsListWithFilter(FilterData filterData) async{
    final response =
    await client.post(_phpUrlAnonsWithFilter,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'city' : filterData.city,
      }),);
    return GamesList.fromJson(json.decode(response.body));
  }
  Future<GamesList> fetchFinishedWithFilter(FilterData filterData) async{
    final response =
    await client.post(_phpUrlFinishedWithFilter,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'city' : filterData.city,
      }),);
    return GamesList.fromJson(json.decode(response.body));
  }

  Future<String> joinGameByPin(int gameId, String pin, String userId) async{
    final response =
    await client.post(_phpJoinGameByPin,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'gameId': gameId.toString(),
        'pin' : pin,
        'userId' : userId,
      }),);
    return response.body.toString();
  }

  Future<String> joinGameByFee(String gameId, String userId) async{
    final response =
    await client.post(_phpJoinGameByFee,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'gameId': gameId,
        'userId' : userId,
      }),);
    return response.body.toString();
  }
}