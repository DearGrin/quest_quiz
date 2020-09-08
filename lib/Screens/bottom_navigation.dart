import 'package:flutter/material.dart';
import 'package:quest_quiz/Models/games_model.dart';
import 'package:quest_quiz/Screens/active_games_screen.dart';
import 'package:quest_quiz/Screens/calendar_screen.dart';
import 'package:quest_quiz/Screens/profile_screen.dart';
import 'package:quest_quiz/Screens/test_screen.dart';

import 'countdown.dart';
import 'game_card_ui.dart';
import 'level_screen.dart';

class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => new _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _pageIndex = 0;
  PageController _pageController;

  List<Widget> tabPages = [
    CalendarScreen(),
   // GameCardUI(GamesModel()), // todo fix error with null params
        //"title", "subtititle", "date", "https://sun9-24.userapi.com/c854124/v854124876/1ac857/TTCdDLYqD8w.jpg", "dfhvjdfv dkfjvgndkjfnv wkenmglkwenv  kgwlekg","https://sun9-24.userapi.com/c854124/v854124876/1ac857/TTCdDLYqD8w.jpg", false
    ActiveGamesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: onTabTapped,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem( icon: Icon(Icons.calendar_today), title: Text("Calendar")),
            BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), title: Text("Game")),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profile")),
          ],

        ),
        body: PageView(
          children: tabPages,
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
}