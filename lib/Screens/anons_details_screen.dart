import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/games_list_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class AnonsDetails extends StatefulWidget {
  final GamesListBloc gamesListBloc = GamesListBloc();

  final int _gameId;
  final String _title;
  final String _date;
  final String _subtitle;
  final String _imageUrl;
  final String _details;
  final String _link;
  AnonsDetails(this._gameId, this._title, this._date, this._subtitle, this._imageUrl, this._details, this._link);

  @override
  State<StatefulWidget> createState() {
    return AnonsDetailsState();
  }
}

class AnonsDetailsState extends State<AnonsDetails>{
  final TextEditingController _pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: FlatButton(
                onPressed: _showPinField,
                child: Text("Join event"),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 400,
              child: Stack(
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  Center(child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: widget._imageUrl, fit: BoxFit.contain,),
                  ),
                ],
              ),
            ),
            Text(widget._title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            ),
            Text(widget._date,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
            ),
            Text(widget._subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
            ),
            Text(widget._details,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 10.0),),
          ],
        ),
      ),
    );
  }


  _showPinField(){
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose option'),
          actions: <Widget>[
            FlatButton(
              child: Text('Enter PIN'),
              onPressed: _showEnterPin,
            ),
            FlatButton(
              child: Text('Buy'),
              onPressed: (){},
            ),
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showEnterPin(){
    Navigator.of(context).pop();
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            enterPinForm(),
          ],
        );
      },
    );
  }


  Widget enterPinForm(){
    return Column(
      children: [
        TextField(
          controller: _pinController,
        ),
        FlatButton(
          child: Text('Confirm'),
          onPressed: _submitPin(_pinController.text), // todo verify pin
        ),
      ],
    );
  }

  _submitPin(String pin) async{
   String callback = await gamesListBloc.joinGameByPin(widget._gameId, pin);
   if(callback == "success")
     {
       Flushbar(
         message: callback,
         duration: Duration(seconds: 2),
         backgroundColor: Colors.green,
         flushbarPosition: FlushbarPosition.TOP,
       )..show(context);
       Navigator.of(context).pop();
     }
   else
     {
       Flushbar(
         message: callback,
         duration: Duration(seconds: 2),
         backgroundColor: Colors.red,
         flushbarPosition: FlushbarPosition.TOP,
       )..show(context);
     }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}



