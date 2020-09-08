import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_quiz/Models/games_model.dart';
import 'package:quest_quiz/Screens/settings_ui.dart';

import 'account_info_ui.dart';

class ProfileScreen extends StatefulWidget{
  //TODO add bloc
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen>{
  @override
  void initState(){
    // TODO init bloc
    super.initState();
  }
  @override
  void dispose(){
    // TODO dispose bloc
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: FlatButton(
              onPressed: () {
                _logout();
              },
                child: Text("Log out"),
              ),
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListView(
          children: [
            AccountInfo(true, "Grin", "99@ry", "8909", "Moscow"),
            ProfileSettings(),
           // gameList(), //TOdo fix the params
          ],
        ),
      ),
    );
  }
  Widget gameList(AsyncSnapshot<GamesList> snapshot){
    return ListView.builder(
        itemCount: snapshot.data.anonsList.length,
        itemBuilder: (BuildContext context, int index){
          return gameListItem(); // Todo pass params to the item
        }
    );
  }
  Widget gameListItem(){ // TODO add card layout
    return Card(
      child: Container(),
    );
  }

  _logout(){
    //TODO logout
    print("log out");
  }
}