import 'dart:async';

import 'package:clock4/costant/theme-data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'clockview.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezone = now.timeZoneOffset.toString().split('.').first;
    var offsetsign = '';
    if (!timezone.startsWith('-')) offsetsign = '+';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              'Orologio',
              style: TextStyle(
                  fontFamily: 'avenir',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DigitalclockView(),
                Text(
                  formattedDate,
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
                alignment: Alignment.center,
                child: ClockView(
                  size: MediaQuery.of(context).size.height / 4,
                )),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Timezone',
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 24),
                ),
                SizedBox(
                  width: 16,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'UTC ' + offsetsign + ' ' + timezone.split(':').first,
                      style: TextStyle(
                          fontFamily: 'avenir',
                          color: Colors.white,
                          fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DigitalclockView extends StatefulWidget {
  const DigitalclockView({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DigitalClockViewState();
  }
}

class DigitalClockViewState extends State<DigitalclockView> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      var minutoprec = DateTime.now().add(Duration(seconds: -1)).minute;
      var minutodopo = DateTime.now().minute;
      if (minutoprec != minutodopo) {
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: TextStyle(
          fontFamily: 'avenir',
          color: CustomColors.primaryTextColor,
          fontSize: 60),
    );
  }
}
