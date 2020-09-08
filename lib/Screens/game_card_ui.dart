import 'package:flutter/material.dart';
import 'package:quest_quiz/Models/games_model.dart';
import 'package:quest_quiz/Screens/results_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import 'anons_details_screen.dart';

class GameCardUI extends StatefulWidget{

  final GamesModel game;
  GameCardUI(this.game);

  @override
  State<StatefulWidget> createState() {
   return GameCardUIState();
  }
}

class GameCardUIState extends State<GameCardUI>{
  @override
  void initState(){
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return gameCard();
  }
  Widget gameCard(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: _onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: anonsImage(widget.game.imageUrl)),
                Expanded(
                    flex: 1,
                    child: cardInfo(widget.game.title, widget.game.date, widget.game.subtitle)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget anonsImage(String url){
    return Container(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          Center(child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: url, fit: BoxFit.cover,),
          ),
        ],
      ),
    );
  }
  Widget cardInfo(String title, String date, String subtitle){
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          Text(
            date,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12.0,
            ),
          ),
          Text(
            subtitle,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
  _onTap(){
    if(!widget.game.isFinished)
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnonsDetails(widget.game.id ,widget.game.title, widget.game.date, widget.game.subtitle, widget.game.imageUrl, widget.game.details, widget.game.link)),
      );
    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultsScreen(widget.game.id)), //TODO results screen
      );
    }
  }
}