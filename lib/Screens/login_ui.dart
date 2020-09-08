import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/registration_bloc.dart';

class Login extends StatefulWidget{
  final RegistrationBloc registrationBloc = RegistrationBloc();
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login>{
  final _loginKey = GlobalKey<FormState>();
  String _login;
  String _pass;
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
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Log in",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Form(
                key: _loginKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
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
                      onChanged: (value) => setState(() => _login = value),
                      onSaved: (value) => setState(() => _login = value),
                      // ignore: missing_return
                      validator: (value){
                        String pattern = r'(^[a-zA-Z0-9 ]*$)';
                        RegExp regExp = new RegExp(pattern);
                        if (value.isEmpty) {
                          return 'Login is required';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Login must be a-z and A-Z and digits';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.vpn_key),
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
                      onChanged: (value) => setState(() => _pass = value),
                      onSaved: (value) => setState(() => _pass = value),
                      // ignore: missing_return
                      validator: (value){
                        if(value.length < 6){
                          return 'a minimum of 6 characters is required';
                        }
                      },
                    ),
                  ],
                ),
              ),
              RaisedButton( // sizedBox may be needed
                color: Colors.blue,
                onPressed: _signIn,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text(
                  "Log in",
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
      ),
    );
  }
  _signIn(){
    final form = _loginKey.currentState;
    if(form.validate()) {
        form.save();
        final String callback =  registrationBloc.signIn(_login, _pass)as String;
        if(callback == 'success')
        {
          Flushbar(
            message: callback,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
            flushbarPosition: FlushbarPosition.TOP,
          )..show(context);
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
  }
}