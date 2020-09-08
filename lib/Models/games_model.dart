
class GamesModel {
  int id;
  String title;
  String subtitle;
  String date;
  String imageUrl;
  String city;
  bool isFinished;
  String details;
  String link;

  GamesModel({this.id, this.title, this.subtitle, this.date, this.imageUrl, this.city, this.isFinished, this.details, this.link});

  factory GamesModel.fromJson(Map<String, dynamic> parsedJson){
    return GamesModel(
        id: parsedJson['id'],
        title: parsedJson['title'],
        subtitle: parsedJson['subtitle'],
        date: parsedJson['date'],
        imageUrl: parsedJson['imageUrl'],
        city: parsedJson['city'],
        isFinished: parsedJson['isFinished'],
        details: parsedJson['details'],
        link: parsedJson['link']
    );
  }
}
/*
AnonsModel(result){
  id = result['id'];
  title = result['title'];
  subtitle = result['subtitle'];
  date = result['date'];
  imageUrl = result['imageUrl'];
  city = result['city'];
  isFinished = result['isFinished'];
  details = result['details'];
  link = result['link'];
  }

 */


class GamesList {
  List<GamesModel> anonsList;

  GamesList({this.anonsList});

  factory GamesList.fromJson(Map<String, dynamic> parsedJson){
    var _list = parsedJson['games'] as List;
    List<GamesModel> _games = _list.map((i) => GamesModel.fromJson(i)).toList();

    return GamesList(
        anonsList: _games
    );
  }
}

class FilterData{
  String city;
  FilterData({this.city});
}

/*
AnonsList.fromJson(Map<String, dynamic> parsedJson){
List<AnonsModel> temp = [];
for (int i = 0; i < parsedJson.length; i++){
AnonsModel result = AnonsModel(parsedJson[i]);
temp.add(result);
}
_results = temp;
}
List<AnonsModel> get results =>_results;

 */

