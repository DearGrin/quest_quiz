import 'package:quest_quiz/API/repository.dart';
import 'package:quest_quiz/Models/games_model.dart';
import 'package:rxdart/rxdart.dart';

class GamesListBloc{
  final _api = Repository();
  final _anonsFetcher = PublishSubject<GamesList>();
  final _finishedFetcher = PublishSubject<GamesList>();
  final _activeGamesFetcher = PublishSubject<GamesList>();

  Stream<GamesList> get anonsList => _anonsFetcher.stream;
  Stream<GamesList> get finishedList => _finishedFetcher.stream;
  Stream<GamesList> get activeGamesList => _activeGamesFetcher.stream;

  void fetchAnonsList() async{
    GamesList anonsList = await _api.fetchAnons();
    _anonsFetcher.sink.add(anonsList);
}
  void fetchFinishedList() async{
    GamesList anonsList = await _api.fetchFinished();
    _finishedFetcher.sink.add(anonsList);
}

void fetchActiveGames() async{
    final String userId = ''; // todo get userId
    GamesList activeGamesList = await _api.fetchActiveGames(userId);
    _activeGamesFetcher.sink.add(activeGamesList);
}

void fetchAnonsListWithFilter(FilterData filterData) async{
  GamesList anonsList = await _api.fetchAnonsListWithFilter(filterData);
  _anonsFetcher.sink.add(anonsList);
}

void fetchFinishedListWithFilter(FilterData filterData) async{
    GamesList anonsList = await _api.fetchFinishedWithFilter(filterData);
    _finishedFetcher.sink.add(anonsList);
}

Future<String> joinGameByPin(int gameId, String pin) async{
    String userId = ""; // todo get user id
    String callback = await _api.joinGameByPin(gameId, pin, userId);
    return callback;
}

Future<String> joinGame(String gameId) async{
  String userId = ""; // todo get user id
  // todo payment dialog
  // (gameId, userId, price)
  String callback = 'join game';
  return callback;
}

  void dispose(){
  _anonsFetcher.close();
  _finishedFetcher.close();
  _activeGamesFetcher.close();
  }
}
final gamesListBloc = GamesListBloc();