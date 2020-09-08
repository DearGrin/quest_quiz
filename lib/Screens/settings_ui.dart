import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/registration_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettings extends StatefulWidget{
  final RegistrationBloc registrationBloc = RegistrationBloc();
 // bool _isPushEnabled;
  //ProfileSettings(this._isPushEnabled);

  @override
  State<StatefulWidget> createState() {
   return ProfileSettingsState();
  }
}
class ProfileSettingsState extends State<ProfileSettings>{
  @override
  void initState(){
    registrationBloc.checkPush();
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Settings",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Push Notifications",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: FutureBuilder(
                  future: registrationBloc.checkPush(),
                  builder: (context, snapshot){
                        return CupertinoSwitch(
                          value: snapshot.data,
                          onChanged: (value) => _pushChange(value),
                        );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "By logging in you agree with EULA",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              FlatButton(
                onPressed: _openUrl,
                child: Text(
                  "open EULA",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
  _pushChange(bool value) async{
    // TODO change push
    await registrationBloc.pushChange(value);
    setState(() => registrationBloc.isPushEnabled = value);
    //print("toggle push " + registrationBloc.isPushEnabled.toString());

  }
  _openUrl() async{
    // TODO make open url function
    print("open url");
    String _url = "https://yandex.ru"; // TODO add url
      if (await canLaunch(_url)) {
      await launch(_url);
      } else {
    throw 'Could not launch $_url';
     }
  }
}