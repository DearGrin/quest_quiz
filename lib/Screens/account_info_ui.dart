import 'package:flutter/material.dart';
import 'package:quest_quiz/Screens/login_register_screen.dart';

import 'edit_account_info_ui.dart';


class AccountInfo extends StatefulWidget{
  // todo get the model
  final bool _isLogged;
  final String _name;
  final String _email;
  final String _phone;
  final String _city;

  const AccountInfo(this._isLogged, this._name, this._email, this._phone, this._city);

  @override
  State<StatefulWidget> createState() {
   return AccountInfoState();
  }
}

class AccountInfoState extends State<AccountInfo>{
 /* for fast testing
  final bool _isLogged = true;
  final String _name = "Grin";
  final String _email = "999@ru";
  final String _phone = "89097035999";
  final String _city = "Ekaterinburg";
  */
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
    if(widget._isLogged)
      {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row( // Title
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Account Info",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      iconSize: 17.0,
                      onPressed: _edit,
                    ), // TODO change for edit button
                  ],
                ),
                Row( // Name
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name:",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    ),
                    Text(widget._name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                  ],
                ),
                Row( // email
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email:",
                  style: TextStyle(
                    fontSize: 14.0,
                    ),
                    ),
                    Text(widget._email,
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                  ],
                ),
                Row( // Phone
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Phone:",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Text(widget._phone,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    ),
                  ],
                ),
                Row( // city
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("City:",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Text(widget._city,
                    textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    else
      {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please Log in or register to gain full access for all app functions",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                RaisedButton( // sizedBox may be needed
                  color: Colors.blue,
                  onPressed: _login,
                    shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: Text(
                        "Log In/Sigh up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),

                ),
              ],
            ),
          ),
        );
      }
  }
  _login(){
    // TODO open log in page
    Navigator.push<void>(context, MaterialPageRoute(builder: (context) => LoginOrRegisterScreen(), fullscreenDialog: true));
    print("click");
  }
  _edit(){
    // TODO edit function
    //var a = UserSighUp.userData(widget._name, widget._email, widget._phone, widget._city);
    Navigator.push<void>(context, MaterialPageRoute(builder: (context) => EditAccountInfo(widget._name, widget._email, widget._phone, widget._city), fullscreenDialog: true));
    print("edit");
  }
}