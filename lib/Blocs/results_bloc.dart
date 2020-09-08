import 'package:quest_quiz/API/repository.dart';
import 'package:quest_quiz/Models/results_model.dart';
import 'package:rxdart/rxdart.dart';

class ResultsBloc{
  final _api = Repository();
  final _resultsFetcher = PublishSubject<Results>();
  Stream<Results> get results => _resultsFetcher.stream;

  // TODO may be add seperate streams for rows and columns
  void fetchResults(int id) async{
    Results resultsModel = await  _api.fetchResults(id);
    _resultsFetcher.sink.add(resultsModel);
  }
  void dispose(){
    _resultsFetcher.close();
  }
}
final resultsBloc = ResultsBloc();