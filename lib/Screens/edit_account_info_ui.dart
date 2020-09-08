import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/registration_bloc.dart';

// TODO get the models
class UserSighUp{
  String login;
  String pass;
  String pass2;
  String name;
  String email;
  String phone;
  String city;
  UserSighUp({this.login, this.pass, this.pass2, this.name, this.email, this.phone, this.city});
}

class EditAccountInfo extends StatefulWidget{
  final RegistrationBloc registrationBloc = RegistrationBloc();
  final String _name;
  final String _email;
  final String _phone;
  final String _city;

  EditAccountInfo(this._name, this._email, this._phone, this._city);
  @override
  State<StatefulWidget> createState() {
    return EditAccountInfoState();
  }
}

class EditAccountInfoState extends State<EditAccountInfo>{
  final _editForm = GlobalKey<FormState>();
  final _formResult = UserSighUp();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit account info",
          style: TextStyle(
              fontSize: 14.0,
          ),
        ),
          actions: [
            FlatButton(
              child: Text("Save"),
              onPressed: _save, // TODo edit save function
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Card(
              child: Form(
                key: _editForm,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Must be at least 3 characters',
                          labelText: 'Name *',
                          hintStyle: TextStyle(
                              fontSize: 12.0
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 12.0
                        ),
                        autocorrect: false,
                        autovalidate: false,
                        initialValue: widget._name,
                        onChanged: (value) => setState(() => _formResult.name = value),
                        onSaved: (value) => setState(() => _formResult.name = value),
                        // ignore: missing_return
                        validator: (value){
                          String pattern = r'(^[a-zA-Z ]*$)';
                          RegExp regExp = new RegExp(pattern);
                          if (value.isEmpty) {
                            return 'Name is required';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Name must be a-z and A-Z';
                          }
                          return null;
                        },), // name
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Email where you will receive access details for games',
                          labelText: 'Email *',
                          hintStyle: TextStyle(
                              fontSize: 12.0
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 12.0
                        ),
                        autocorrect: false,
                        autovalidate: false,
                        keyboardType: TextInputType.emailAddress,
                        initialValue: widget._email,
                        onChanged: (value) => setState(() => _formResult.email = value),
                        onSaved: (value) => setState(() => _formResult.email = value),
                        // ignore: missing_return
                        validator: (value){
                          String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = new RegExp(pattern);
                          if (value.isEmpty) {
                            return 'Email is required';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                      ), // email
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'How can we call you in case of emergency during the game?',
                          labelText: 'Phone *',
                          hintStyle: TextStyle(
                              fontSize: 12.0
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 12.0
                        ),
                        autocorrect: false,
                        autovalidate: false,
                        keyboardType: TextInputType.phone,
                        initialValue: widget._phone,
                        onChanged: (value) => setState(() => _formResult.phone = value),
                        onSaved: (value) => setState(() => _formResult.phone = value),
                        // ignore: missing_return
                        validator: (value){
                          String pattern = r'(^[+0-9]*$)';
                          RegExp regExp = new RegExp(pattern);
                          if (value.replaceAll(" ", "").isEmpty) {
                            return 'Mobile is required';
                          } else if (value.replaceAll(" ", "").length != 12) {
                            return 'Mobile number must 12 digits';
                          } else if (!regExp.hasMatch(value.replaceAll(" ", ""))) {
                            return 'Mobile number must be digits';
                          }
                          return null;
                        },
                      ), // phone

                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: Text("City"),
                        value: widget._city,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            _formResult.city = newValue;
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
                        validator: (value){
                          if(value == null){
                            return 'City is required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  _save(){
    //TODO do add some callback
    final form = _editForm.currentState;
    if(form.validate()){
      form.save();
      registrationBloc.editUserData(_formResult.name, _formResult.email, _formResult.phone, _formResult.city);
      Navigator.pop(context);
    }
  }
}