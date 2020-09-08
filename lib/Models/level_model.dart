

class Level{
  int duration;
  List<LevelItem> levelItems;

 // List<int> hints; // there is a problem to build 2 builders of list so its easier to just add hints to levelItems

  Level({this.duration, this.levelItems});

  factory Level.fromJson(Map<String, dynamic> parsedJson){

    var _list = parsedJson['levelItems'] as List;
    List<LevelItem> _levelItems = _list.map((i) => LevelItem.fromJson(i)).toList();

    /* the previous implementation
    var hintsFromJson = parsedJson['hints'];
    List<int> _listOfHints = hintsFromJson.cast<int>();
 */
    return Level(
      duration: parsedJson['duration'],
      levelItems: _levelItems,
    );
  }
}

class LevelItem{
  // possible types: text, pic, video, audio, hint
  String type;
  String content;

  LevelItem({this.type, this.content});

  factory LevelItem.fromJson(Map<String, dynamic> parsedJson){
    return LevelItem(
      type: parsedJson['type'],
      content: parsedJson['content']
    );
  }
}
class AnswerCallback{
  bool isCorrect;
  String callback;
  AnswerCallback({this.isCorrect, this.callback});

  factory AnswerCallback.fromJson(Map<String, dynamic> parsedJson){
    return AnswerCallback(
        isCorrect: parsedJson['isCorrect'],
        callback: parsedJson['callback']
    );
  }
}


/*
class Hint{
  int id;
  List<LevelItem> hintItems;

  Hint({this.id, this.hintItems});

  factory Hint.fromJson(Map<String, dynamic> parsedJson){
    var _list = parsedJson['levelItems'] as List;
    List<LevelItem> _hintItems = _list.map((i) => LevelItem.fromJson(i)).toList();

    return Hint(
      id: parsedJson['id'],
      hintItems: _hintItems
    );
  }
}

 */
