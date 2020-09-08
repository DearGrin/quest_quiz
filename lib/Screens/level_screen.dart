import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/level_bloc.dart';
import 'package:quest_quiz/Models/level_model.dart';
import 'package:quest_quiz/Screens/countdown.dart';
import 'package:quest_quiz/Screens/video_player_ui.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flushbar/flushbar.dart';

import 'audio_player_ui.dart';

class LevelScreen extends StatefulWidget{
  final LevelBloc levelBloc = LevelBloc();
  final int gameId;
  LevelScreen(this.gameId);
  @override
  State<StatefulWidget> createState() {
   return LevelScreenState();
  }
}

class LevelScreenState extends State<LevelScreen>{
  AudioPlayer audioPlayer = AudioPlayer();
  TextEditingController _controller;

  @override
  void initState(){
    levelBloc.fetchLevel();
    _controller = TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    _controller.dispose();
    audioPlayer.dispose();
    levelBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  //  final List<String> contents = ["text", "pic", "audio", "video", "empty"];
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: levelBloc.level,
        builder: (context, AsyncSnapshot<Level> snapshot){
          if(snapshot.hasData){
            return levelBody(snapshot);
          }
          else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          //else{
          //  return Text("No games found");
          // }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget levelBody(AsyncSnapshot<Level> snapshot){
    return Scaffold(
      appBar: AppBar(
        title: Text("Level"), // TODO get level id or name
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _showSendForm,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8.0),
          child:Countdown(snapshot.data.duration),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Expanded(
            child: Column(
              children: snapshot.data.levelItems.map((e) => levelContent(e),).toList(),
            ),
          ),
        ),
      );
  }

Widget levelContent(LevelItem levelItem){
    switch(levelItem.type) {
      case "text":
          return Column(
            children: [
              Container(
                child: Text(
                  levelItem.content,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                height: 20.0,
              ),
            ],
          );
          break;
      case "pic":
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                      child: CircularProgressIndicator()),
                ),
                Center(child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: levelItem.content,
                  fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 20.0,
                ),
             ],
            ),
          ]
        );
        break;
      case "audio":
          return Column(
            children: [
              PlayerWidget( // TODO pass audio url
                  url: levelItem.content,
              ),
              Container(
                height: 20.0,
              ),
            ],
          );
        break;
      case "video": // TODO pass video
        return Column(
          children: [
            VideoPlayerUI(
                levelItem.content,
            ),
            Container(
              height: 20.0,
            ),
          ],
        );
        break;
      case "hint":
        return Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Countdown(int.parse(levelItem.content)),
            ),
          ),
        );
        break;
      default:
        return Container(
          height: 300,
        );
        break;
    }
  }

  _showSendForm(){
    Scaffold.of(context).showBottomSheet<void>(
          (BuildContext context) {
        return Container(
          height: 150,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Answer",
                    ),
                    onSubmitted: (value) => _submitAnswer(value),
                  ),
                ),
                RaisedButton(
                  child: const Text(
                      "Hide",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  _submitAnswer(String answer) async{
    AnswerCallback callback = await levelBloc.sendAnswer(answer);
    if(callback.isCorrect) {
      Flushbar(
        message: callback.callback,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    }
    else{
      Flushbar(
        message: callback.callback,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    }
  }
}