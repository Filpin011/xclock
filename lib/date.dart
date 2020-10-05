import 'package:clock4/enums.dart';
import 'package:clock4/modelli/alarm_info.dart';

import 'modelli/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Orologio', imagesource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'Sveglia', imagesource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.timer,
      title: 'Timer', imagesource: 'assets/timer_icon.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imagesource: 'assets/stopwatch_icon.png'),
];

List<AlarmInfo> alarmInfo = [];
