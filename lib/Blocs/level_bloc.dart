import 'package:quest_quiz/API/repository.dart';
import 'package:quest_quiz/Models/level_model.dart';
import 'package:rxdart/rxdart.dart';

class LevelBloc{
  final _api = Repository();
  final _levelFetcher = PublishSubject<Level>();

  Stream<Level> get level => _levelFetcher.stream;

  void fetchLevel () async{
    Level level = await _api.fetchLevel();
    _levelFetcher.sink.add(level);
  }

  Future<AnswerCallback> sendAnswer(String answer) async{
    AnswerCallback callback =  await _api.sendAnswer(answer);
    return callback;
  }

  void dispose(){
    _levelFetcher.close();
  }
}
final LevelBloc levelBloc = LevelBloc();