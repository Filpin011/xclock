import 'package:clock4/enums.dart';
import 'package:clock4/views/clock.dart';

import 'package:clock4/modelli/menu_info.dart';
import 'package:clock4/views/timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:clock4/date.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezone = now.timeZoneOffset.toString().split(':').first;
    var offsetsign = '-';
    if (!timezone.startsWith('-')) offsetsign = '+';

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentmenuinfo) => buildMenuButton(currentmenuinfo))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else
                  return Container(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(text: ''),
                          TextSpan(
                            text: value.title,
                            style: TextStyle(fontSize: 48),
                          ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentmenuinfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32))),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
          color: currentmenuinfo.menuType == value.menuType
              ? Colors.lightBlue[900]
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updatemenu(currentmenuinfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentmenuinfo.imagesource,
                scale: 1.5,
              ),
              SizedBox(height: 16),
              Text(
                currentmenuinfo.title ?? '',
                style: TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
