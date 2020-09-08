import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/games_list_bloc.dart';
import 'package:quest_quiz/Models/games_model.dart';
import 'package:quest_quiz/Screens/level_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class ActiveGamesScreen extends StatefulWidget{
  final GamesListBloc gamesListBloc = GamesListBloc();
  @override
  State<StatefulWidget> createState() {
   return ActiveGamesScreenState();
  }
}

class ActiveGamesScreenState extends State<ActiveGamesScreen>{
  @override
  void initState(){
    gamesListBloc.fetchActiveGames();
    super.initState();
  }
  @override
  void dispose(){
    gamesListBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Active games'),
        ),
        body: Padding(
          padding:  EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: gamesListBloc.activeGamesList,
            builder: (context, AsyncSnapshot<GamesList> snapshot){
              if(snapshot.hasData){
                return buildList(snapshot);
              }
              else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              else{
               return Text("No active games found"); // todo make design better into card
              }
              return Center(child: CircularProgressIndicator());
              },
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<GamesList> snapshot){
    return ListView.builder(
      itemCount: snapshot.data.anonsList.length,
      itemBuilder: (BuildContext context, int index){
        return activeGameCard(snapshot.data.anonsList[index].id ,snapshot.data.anonsList[index].title, snapshot.data.anonsList[index].subtitle, snapshot.data.anonsList[index].date,
            snapshot.data.anonsList[index].imageUrl);
      },
    );
  }

  Widget activeGameCard(int id, String title, String subtitle, String date, String imageUrl){
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: _onTap(id),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: anonsImage(imageUrl)),
              Expanded(
                  flex: 1,
                  child: cardInfo(title, date, subtitle)),
            ],
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
  _onTap(int gameId){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LevelScreen(gameId)));
  }

}