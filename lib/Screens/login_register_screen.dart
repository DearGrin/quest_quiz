import 'package:flutter/material.dart';
import 'package:quest_quiz/Screens/register_ui.dart';
import 'login_ui.dart';

class LoginOrRegisterScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return LoginOrRegisterScreenState();
  }
}

class LoginOrRegisterScreenState extends State<LoginOrRegisterScreen>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Account"),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              isScrollable:  false,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.red, width: 4),
                insets: EdgeInsets.symmetric(horizontal: 20),
              ),
              tabs: [
                Tab( text: "Log in",),
                Tab(text:  "Sigh up",)
              ], // Tabs
            ),
          ),
           body: TabBarView(
             children: [
               Login(),
               Register(),
             ],
          ),
        ),
      ),
    );
  }

}