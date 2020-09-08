import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:quest_quiz/Models/results_model.dart';

class ResultsApi{
  Client client = Client();
  final _phpUrl = ''; // TODO: add php utl

  Future<Results> fetchResults (int id) async{
    final response =
    await client.post(_phpUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
      }),);
    return Results.fromJson(json.decode(response.body));
  }


  Future<Columns> fetchColumns(int id) async{
    final response =
    await client.post(_phpUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
      }),);
    return Columns.fromJson(json.decode(response.body));
  }

  Future<Rows> fetchRows(int id) async {
    final response =
    await client.post(_phpUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
      }),);
    return Rows.fromJson(json.decode(response.body));
  }

}