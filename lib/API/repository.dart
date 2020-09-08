import 'dart:async';

import 'package:quest_quiz/API/firebase_api.dart';
import 'package:quest_quiz/API/games_list_api.dart';
import 'package:quest_quiz/API/level_api.dart';
import 'package:quest_quiz/API/results_api.dart';
import 'package:quest_quiz/API/user_api.dart';
import 'package:quest_quiz/Models/games_model.dart';
import 'package:quest_quiz/Models/level_model.dart';
import 'package:quest_quiz/Models/results_model.dart';


class Repository {
final gamesProvider = GamesListApi();
final resultsProvider = ResultsApi();
final levelProvider = LevelApi();
final userProvider = UserApi();
final fireBaseProvider = FireBaseApi();

Future<GamesList> fetchAnons() => gamesProvider.fetchAnons();
Future<GamesList> fetchFinished() => gamesProvider.fetchFinished();
Future<GamesList> fetchActiveGames(String userId) => gamesProvider.fetchGamesByUser(userId);
Future<GamesList> fetchAnonsListWithFilter(FilterData filterData) => gamesProvider.fetchAnonsListWithFilter(filterData);
Future<GamesList> fetchFinishedWithFilter(FilterData filterData) => gamesProvider.fetchFinishedWithFilter(filterData);

Future<String> joinGameByPin(int gameId, String pin, String userId) => gamesProvider.joinGameByPin(gameId, pin, userId);
Future<String> joinGameByFee(String gameId, String userId) => gamesProvider.joinGameByFee(gameId, userId);

Future<Results> fetchResults(int id) => resultsProvider.fetchResults(id);

Future<Level> fetchLevel() => levelProvider.fetchLevel();
Future<AnswerCallback> sendAnswer(String answer) => levelProvider.sendAnswer(answer);

Future<String> signIn(String email, String password) => fireBaseProvider.signIn(email, password);
Future<String> registrationWithEmailAndPassword(String email, String password) => fireBaseProvider.registerWithEmailAndPassword(email, password);
Future<String> changePassword(String password) => fireBaseProvider.changePassword(password);
Future<void> sendPasswordResetEmail(String email) => fireBaseProvider.sendPasswordResetEmail(email);
Future<String> getUserId() => fireBaseProvider.getUserId();
Future<void> setUserData(String name, String email, String phone, String city, String userId) => userProvider.setUserData(name, email, phone, city, userId);
Future<void> changePush(String userId, bool isPushEnabled) => userProvider.changePush(userId, isPushEnabled);
Future<void> askPushPermission() => userProvider.checkPushPermission();
Future<bool> checkPushPermission() => userProvider.checkPushPermission();
}