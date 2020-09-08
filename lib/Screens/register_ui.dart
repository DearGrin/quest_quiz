import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/registration_bloc.dart';

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

class Register extends StatefulWidget{
  final RegistrationBloc registrationBloc = RegistrationBloc();
  @override
  State<StatefulWidget> createState() {
   return RegisterState();
  }
}
class RegisterState extends State<Register>{
  final _regForm = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState<String>>();
  final _formResult = UserSighUp();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Card(
          child: Form(
            key: _regForm,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Must be at least 3 characters',
                      labelText: 'Login *',
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
                    initialValue: _formResult.login,
                    onChanged: (value) => setState(() => _formResult.login = value),
                    onSaved: (value) => setState(() => _formResult.login = value),
                    // ignore: missing_return
                    validator: (value){
                      String pattern = r'(^[a-zA-Z0-9 ]*$)';
                      RegExp regExp = new RegExp(pattern);
                      if (value.isEmpty) {
                        return 'Login is required';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Login must be a-z and A-Z';
                      }
                      return null;
                    },), // login
                  TextFormField(
                    key: _passKey,
                    decoration: const InputDecoration(
                      hintText: 'Must be at least 6 characters',
                      labelText: 'Password *',
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
                    obscureText: true,
                    initialValue: _formResult.pass,
                    onChanged: (value) => setState(() => _formResult.pass = value),
                    onSaved: (value) => setState(() => _formResult.pass = value),
                    // ignore: missing_return
                    validator: (value){
                      if(value.length < 6){
                        return 'a minimum of 6 characters is required';
                      }
                    },
                  ), // pass
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Must be the same as password',
                      labelText: 'Confirm password *',
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
                    obscureText: true,
                    initialValue: _formResult.pass2,
                    onChanged: (value) => setState(() => _formResult.pass2 = value),
                    onSaved: (value) => setState(() => _formResult.pass2 = value),
                    // ignore: missing_return
                    validator: (value){
                      if(value != _passKey.currentState.value){
                        return 'passwords do not match';
                      }
                    },
                  ), // double pass
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
                    initialValue: _formResult.name,
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
                    initialValue: _formResult.email,
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
                    initialValue: _formResult.phone,
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
               value: _formResult.city,
                icon: Icon(Icons.arrow_downward),
               iconSize: 24,
                elevation: 16,
                onChanged: (String newValue) {
                setState(() {
                  _formResult.city = newValue;
                });
              },
              items: <String>['Moscow', 'Ekaterinburg', 'Piter', 'Chelabynsk']
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
            ),// city - make dropdown
                  RaisedButton(color: Colors.blue,
                    onPressed: _sighUp,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      "Sigh up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),), // submit
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  _sighUp(){
    // TODO add sigh up func
    final form = _regForm.currentState;
    if(form.validate()){
      form.save();
      String callback = registrationBloc.registrationWithEmailAndPassword(_formResult.email, _formResult.pass, _formResult.name, _formResult.phone, _formResult.city)as String;
      if(callback == 'success'){
        Flushbar(
          message: callback,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context);
      }
      else{
        Flushbar(
          message: callback,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context);
      }
    }
  }
}