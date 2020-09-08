import 'dart:async';

import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  int duration;
  Countdown(this.duration);
  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {

  Timer _timer;
  int seconds;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(constructTime(seconds),
      style: TextStyle(
        color: Colors.white,
      ),),
    );
  }

  // Time formatting, converted to the corresponding hh:mm:ss format according to the total number of seconds
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) + ":" + formatTime(minute) + ":" + formatTime(second);
  }

  // Digital formatting, converting 0-9 time to 00-09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  @override
  void initState() {
    super.initState();
    seconds = widget.duration; //TODO get from remote seconds left
    startTimer();
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // Update interface
      setState(() {
        // minus one second because it calls back once a second
        seconds--;
      });
      if (seconds == 0) {
        // Countdown seconds 0, cancel timer
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}