// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/builders/map.dart';
import 'package:cotwcompanion/builders/need_zones/reserve_need_zones.dart';
import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/model/reserve.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/scrollbar.dart';
import 'package:cotwcompanion/widgets/slider.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:cotwcompanion/widgets/switch_text.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:cotwcompanion/widgets/title_big_button.dart';
import 'package:cotwcompanion/widgets/title_big_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActivityNeedZones extends StatefulWidget {
  const ActivityNeedZones({
    Key? key,
  }) : super(key: key);

  @override
  ActivityNeedZonesState createState() => ActivityNeedZonesState();
}

class ActivityNeedZonesState extends State<ActivityNeedZones> {
  final List<bool> _shownClasses = [false, false, false, false, false, false, false, false, false];
  final List<bool> _disabledClasses = [true, true, true, true, true, true, true, true, true];

  late List<int> _allClasses = [];
  late RestartableTimer _timer;

  bool _stopped = false;
  bool _compact = false;
  bool _classSwitches = true;
  int _hour = 8;
  int _minute = 30;
  int _second = 0;
  int _reserveId = 1;

  @override
  void initState() {
    _timer = RestartableTimer(const Duration(microseconds: 995572), () => _changeTime());
    _allClasses = HelperJSON.getReserve(_reserveId).allClasses;
    _resetSwtiches();
    super.initState();
  }

  void _adjustSecond() {
    int inGameSecond = 995572;
    setState(() {
      _timer.cancel();
      if (_hour < 4) {
        inGameSecond = 1000717;
      } else if (_hour > 15) {
        inGameSecond = 1021850;
      }
      _timer = RestartableTimer(Duration(microseconds: inGameSecond), () => _changeTime());
    });
  }

  void _resetTimer() {
    setState(() {
      _stopped = !_stopped;
      _second = 0;
      _timer.reset();
    });
  }

  void _changeTime() {
    setState(() {
      if (!_stopped) {
        _timer.reset();
        _second += 1;
        if (_second == 15) {
          _second = 0;
          _minute += 1;
          if (_minute == 60) {
            _minute = 0;
            _hour == 24 ? _hour = 0 : _hour += 1;
            _adjustSecond();
          }
        }
      }
    });
  }

  void _resetSwtiches() {
    for (int index = 0; index < 9; index++) {
      _shownClasses[index] = false;
      _disabledClasses[index] = true;
      if (_allClasses.contains(index + 1)) {
        _shownClasses[index] = true;
        _disabledClasses[index] = false;
      }
    }
  }

  Widget _buildTimeSliders() {
    return Column(children: [
      WidgetSlider(
          values: [_hour.toDouble()],
          text: _hour.toString(),
          min: 0,
          max: 23,
          onDrag: (id, lower, upper) {
            setState(() {
              _hour = lower.toInt();
              _adjustSecond();
            });
          }),
      WidgetSlider(
          values: [_minute.toDouble()],
          text: _minute.toString(),
          min: 0,
          max: 59,
          onDrag: (id, lower, upper) {
            setState(() {
              _minute = lower.toInt();
            });
          })
    ]);
  }

  Widget _buildReserves() {
    return _compact
        ? Container()
        : Container(
            padding: const EdgeInsets.all(0),
            child: DropdownButton(
              dropdownColor: Interface.dropDown,
              underline: Container(),
              icon: Container(),
              elevation: 0,
              itemHeight: 60,
              menuMaxHeight: 300,
              isExpanded: true,
              value: _reserveId,
              onChanged: (dynamic value) {
                setState(() {
                  _reserveId = value;
                  _allClasses = HelperJSON.getReserve(value).allClasses;
                  _resetSwtiches();
                });
              },
              items: _buildDropDownReserves(),
            ));
  }

  List<DropdownMenuItem> _buildDropDownReserves() {
    List<DropdownMenuItem> items = [];
    for (Reserve reserve in HelperJSON.reserves) {
      items.add(DropdownMenuItem(
          value: reserve.id,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: AutoSizeText(
                reserve.getName(context.locale),
                maxLines: 1,
                style: Interface.s16w300n(Interface.dark),
              ))));
    }
    return items;
  }

  Widget _buildSwitches(bool portrait, Color color) {
    _classSwitches = !portrait ? true : _classSwitches;
    return Row(children: [
      _compact
          ? WidgetButtonIcon(
              buttonSize: 45,
              icon: "assets/graphics/icons/min_max.svg",
              color: color,
              background: Colors.transparent,
              onTap: () {
                setState(() {
                  _classSwitches = !_classSwitches;
                });
              },
            )
          : Container(),
      portrait
          ? WidgetSwitchIcon(
              buttonSize: 45,
              icon: "assets/graphics/icons/view_compact.svg",
              activeIcon: "assets/graphics/icons/view_expanded.svg",
              color: color,
              background: Colors.transparent,
              activeColor: color,
              activeBackground: Colors.transparent,
              isActive: _compact,
              onTap: () {
                setState(() {
                  _compact = !_compact;
                  _classSwitches = !_compact;
                });
              },
            )
          : Container()
    ]);
  }

  Widget _buildTime(Color color) {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      AnimatedContainer(
          width: 40,
          padding: const EdgeInsets.only(right: 3),
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(
            _hour.toInt().toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Interface.s18w500n(Interface.dark),
          )),
      AnimatedContainer(
          width: 15,
          duration: const Duration(microseconds: 200),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 3.5,
                height: 3.5,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
                margin: const EdgeInsets.only(bottom: 2)),
            Container(
              width: 3.5,
              height: 3.5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: const EdgeInsets.only(top: 2),
            )
          ])),
      AnimatedContainer(
          width: 40,
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(
            _minute.toInt().toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Interface.s18w500n(Interface.dark),
          )),
      AnimatedContainer(
          width: 15,
          duration: const Duration(microseconds: 200),
          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 3.5,
                height: 3.5,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(bottom: 2)),
            Container(
              width: 3.5,
              height: 3.5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(top: 2),
            )
          ])),
      AnimatedContainer(
          width: 40,
          padding: const EdgeInsets.only(left: 3),
          duration: const Duration(microseconds: 200),
          child: AutoSizeText(
            _second.toInt().toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Interface.s18w500n(Interface.dark),
          )),
    ]);
  }

  Widget _buildActualTimeAndCompact(bool portrait) {
    Color color = Interface.dark;
    Color background = Interface.primary.withOpacity(0.5);
    return AnimatedContainer(
        height: 45,
        padding: const EdgeInsets.only(left: 20, right: 20),
        duration: const Duration(microseconds: 200),
        color: background,
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(child: _buildTime(color)),
          _buildSwitches(portrait, color),
        ]));
  }

  List<Widget> _buildClassSwitches() {
    double width = MediaQuery.of(context).size.width - 60;
    double size = width > 305 ? 25 : ((width - 56) / 9);
    double margin = width > 305 ? 10 : 7;
    List<Widget> switches = [];
    for (int index = 0; index < 9; index++) {
      switches.add(Container(
          margin: EdgeInsets.only(right: index < 8 ? margin : 0),
          child: WidgetSwitchText(
            buttonWidth: size,
            buttonHeight: size,
            text: "${index + 1}",
            color: Interface.disabled.withOpacity(_disabledClasses.elementAt(index) ? 0.3 : 1),
            background: Interface.disabled.withOpacity(_disabledClasses.elementAt(index) ? 0.1 : 0.3),
            isActive: _shownClasses.elementAt(index),
            disabled: _disabledClasses.elementAt(index),
            onTap: () {
              setState(() {
                _shownClasses[index] = !(_shownClasses.elementAt(index));
              });
            },
          )));
    }
    return switches;
  }

  Widget _buildClass() {
    double width = MediaQuery.of(context).size.width - 60;
    double size = width > 305 ? 305 : width;
    return _classSwitches
        ? Container(
            width: width + 60,
            height: 70,
            color: Interface.title,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SizedBox(
                width: size,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildClassSwitches(),
                )))
        : Container();
  }

  Widget _buildTimeChangerAndReserve() {
    return _compact
        ? Container()
        : Column(children: [
            WidgetTitleBigSwitch(
              primaryText: tr('time'),
              icon: "assets/graphics/icons/stop.svg",
              color: Interface.alwaysDark,
              background: Interface.red,
              activeIcon: "assets/graphics/icons/play.svg",
              activeColor: Interface.alwaysDark,
              activeBackground: Interface.blue,
              isActive: _stopped,
              onTap: () {
                _resetTimer();
              },
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
              child: _buildTimeSliders(),
            ),
            WidgetTitleBigButton(
              primaryText: tr('reserve'),
              icon: "assets/graphics/icons/map.svg",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuilderMap(reserveId: _reserveId)),
                );
              },
            )
          ]);
  }

  Widget _buildTimeAndSelectors(bool portrait) {
    return Column(children: [
      _buildActualTimeAndCompact(portrait),
      _buildTimeChangerAndReserve(),
      _buildReserves(),
    ]);
  }

  Widget _buildNeedZones() {
    return Column(children: [
      _compact
          ? Container()
          : WidgetTitleBig(
              primaryText: tr('animal_need_zones'),
            ),
      _buildClass(),
      BuilderReserveNeedZones(
        reserveId: _reserveId,
        hour: _hour,
        classes: _shownClasses,
        compact: _compact,
        classSwitches: _classSwitches,
      )
    ]);
  }

  WidgetAppBar _buildAppBar() {
    return _compact
        ? WidgetAppBar(
            text: "",
            height: 0,
            context: context,
          )
        : WidgetAppBar(
            text: tr('animal_need_zones'),
            context: context,
          );
  }

  Widget _buildPortraitView() {
    return WidgetScaffold(
        appBar: _buildAppBar(),
        body: Column(children: [
          _buildTimeAndSelectors(true),
          _buildNeedZones(),
        ]));
  }

  Widget _buildLandscapeView() {
    _compact = false;
    return WidgetScaffold(
        customBody: true,
        body: Column(children: [
          _buildAppBar(),
          Expanded(
              child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
                flex: 2,
                child: WidgetScrollbar(
                    child: SingleChildScrollView(
                  child: _buildTimeAndSelectors(false),
                ))),
            Flexible(
                flex: 3,
                child: WidgetScrollbar(
                    child: SingleChildScrollView(
                  child: _buildNeedZones(),
                )))
          ]))
        ]));
  }

  Widget _buildWidgets() {
    return OrientationBuilder(builder: ((context, orientation) {
      return orientation == Orientation.portrait ? _buildPortraitView() : _buildLandscapeView();
    }));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
