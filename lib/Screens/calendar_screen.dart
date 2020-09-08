import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/games_list_bloc.dart';
import 'package:quest_quiz/Models/games_model.dart';
import 'package:quest_quiz/Screens/results_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import 'anons_details_screen.dart';


class CalendarScreen extends StatefulWidget{
  final GamesListBloc gamesListBloc = GamesListBloc();
  @override
State<StatefulWidget> createState() {
    return CalendarScreenState();
  }
}
class CalendarScreenState extends State<CalendarScreen> {
  final FilterData _filterData = FilterData();
  @override
  void initState() {
    gamesListBloc.fetchAnonsList();
    gamesListBloc.fetchFinishedList();
    super.initState();
  }
  @override
  void dispose() {
    gamesListBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea( // TODO check for double SafeArea?
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.tune),
                onPressed: _showFilter,
              ),
            ],
            bottom: TabBar(
              isScrollable:  false,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.red, width: 4),
                insets: EdgeInsets.symmetric(horizontal: 20),
              ),
              tabs: [
                Tab( text: "Anons",),
                Tab(text:  "Finished",)
              ], // Tabs
            ),
          ),
            body: TabBarView(
              children: [
                 StreamBuilder(
                    stream: gamesListBloc.anonsList,
                    builder: (context, AsyncSnapshot<GamesList> snapshot){
                      if(snapshot.hasData){
                        return buildList(snapshot);
                      }
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      //else{
                      //  return Text("No games found");
                     // }
                      return Center(child: CircularProgressIndicator());
                      },
            ), // tab 1 anons
               StreamBuilder(
                    stream: gamesListBloc.finishedList,
                    builder: (context, AsyncSnapshot<GamesList> snapshot){
                      if(snapshot.hasData){
                        return buildList(snapshot);
                      }
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      //else{
                      //  return Text("No games found");
                      // }
                      return Center(child: CircularProgressIndicator());
                    }, // tab 2 finished
                ),
              ],
            ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<GamesList> snapshot){
return ListView.builder(
    itemCount: snapshot.data.anonsList.length,
    itemBuilder: (BuildContext context, int index){
return anonsCard(snapshot.data.anonsList[index].id ,snapshot.data.anonsList[index].title, snapshot.data.anonsList[index].subtitle, snapshot.data.anonsList[index].date,
    snapshot.data.anonsList[index].imageUrl, snapshot.data.anonsList[index].details, snapshot.data.anonsList[index].link, snapshot.data.anonsList[index].isFinished);
      },
    );
}

  Widget anonsCard(int id, String title, String subtitle, String date, String anonsImageUrl, String details, String link, bool isFinished){
    return Container(
      height: 400,
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: (){
            if(!isFinished)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnonsDetails(id, title, date, subtitle, anonsImageUrl, details, link)),
                );
              }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultsScreen(id)), //TODO results screen
              );
            }
          },
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: anonsImage(anonsImageUrl),
              ),
              Expanded(
                flex: 2,
                child: cardInfo(title, date, subtitle),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget anonsImage(String url){
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(child: CircularProgressIndicator()),
        Center(child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: url, fit: BoxFit.contain,),
        ),
      ],
    );
  }
  Widget cardInfo(String title, String date, String subtitle){
    return Column(
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
            fontSize: 14.0,
          ),
        ),
        Text(
          subtitle,
    maxLines: 4,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14.0,
        ),
        ),
      ],
    );
  }

  _showFilter(){
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: Text("City"),
                    value: _filterData.city,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        _filterData.city = newValue;
                      });
                    },
                    items: <String>['Moscow', 'Ekaterinburg', 'Piter', 'Chelabynsk'] // todo get list of cities
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    autovalidate: false,
                  ),
                  FlatButton(
                    child: Text('Submit'),
                    onPressed: _onSubmitFilter,
                  ),
                  FlatButton(
                    child: Text('Reset'),
                    onPressed: _onResetFilter,
                  ),
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: _onCancelFilter,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _onSubmitFilter(){
    Navigator.of(context).pop();
    if(DefaultTabController.of(context).index == 0)
    {
      gamesListBloc.fetchAnonsListWithFilter(_filterData);
    }
    else
    {
      gamesListBloc.fetchFinishedListWithFilter(_filterData);
    }
  }

  _onResetFilter(){
    Navigator.of(context).pop();
    if(DefaultTabController.of(context).index == 0)
      {
        gamesListBloc.fetchAnonsList();
      }
    else
      {
        gamesListBloc.fetchFinishedList();
      }

  }

  _onCancelFilter(){
    Navigator.of(context).pop();

  }
}