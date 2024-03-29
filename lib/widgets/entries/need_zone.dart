// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/activities/detail/animal.dart';
import 'package:cotwcompanion/activities/edit/logs.dart';
import 'package:cotwcompanion/miscellaneous/helpers/loadout.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/animal.dart';
import 'package:cotwcompanion/model/zone.dart';
import 'package:cotwcompanion/widgets/icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntryNeedZone extends StatefulWidget {
  final Animal animal;
  final int reserveId, index, count, hour;
  final List<Zone> zones;
  final bool compact, classSwitches;

  const EntryNeedZone({
    Key? key,
    required this.animal,
    required this.reserveId,
    required this.zones,
    required this.hour,
    required this.index,
    required this.count,
    required this.compact,
    required this.classSwitches,
  }) : super(key: key);

  @override
  EntryNeedZoneState createState() => EntryNeedZoneState();
}

class EntryNeedZoneState extends State<EntryNeedZone> {
  final List<int> _finalZones = [];
  final double _itemHeight = 75;
  final int _itemsPerScreen = 10;
  final double _topMenuHeight = 70;
  final double _zoneIconSize = 35;
  final double _zoneIconSpace = 10;
  final double _editIconSize = 20;
  final double _loadoutIconSize = 10;

  double _getSize() {
    double top = widget.compact
        ? widget.classSwitches
            ? _topMenuHeight * 2
            : _topMenuHeight
        : 0;
    double height = (MediaQuery.of(context).size.height - top) / (widget.count <= _itemsPerScreen ? widget.count : _itemsPerScreen);
    return widget.compact
        ? height < _itemHeight
            ? height
            : _itemHeight
        : _itemHeight;
  }

  void _getData() {
    _finalZones.clear();
    if (widget.zones.length != 1) {
      int hourNow = widget.hour;
      int hourAfter = hourNow + 1 == 24 ? 0 : hourNow + 1;
      int hourAfterAfter = hourAfter + 1 == 24 ? 0 : hourAfter + 1;
      for (Zone zone in widget.zones) {
        if ((hourNow >= zone.from && hourNow < zone.to) || (hourAfter >= zone.from && hourAfter < zone.to) || (hourAfterAfter >= zone.from && hourAfterAfter < zone.to)) {
          for (int hour = zone.from; hour < zone.to; hour++) {
            if (hour == hourNow || hour == hourAfter || hour == hourAfterAfter) {
              _finalZones.add(zone.zone);
            }
          }
        }
      }
    } else {
      _finalZones.addAll([4, 4, 4]);
    }
  }

  Widget _getZones() {
    int zoneNow = _finalZones[0];
    int zoneAfter = _finalZones[1];
    int zoneAfterAfter = _finalZones[2];
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      WidgetIcon(
        size: _zoneIconSize,
        icon: Zone.iconForZone(zoneNow),
        color: zoneNow == 4
            ? Interface.dark
            : zoneNow == 3
                ? Interface.light
                : Interface.alwaysDark,
        background: Zone.colorForZone(zoneNow),
      ),
      WidgetIcon(
        size: _zoneIconSize - 5,
        icon: Zone.iconForZone(zoneAfter),
        color: zoneAfter == 4
            ? Interface.dark.withOpacity(0.75)
            : zoneAfter == 3
                ? Interface.light.withOpacity(0.75)
                : Interface.alwaysDark.withOpacity(0.75),
        background: Zone.colorForZone(zoneAfter).withOpacity(0.5),
      ),
      WidgetIcon(
        size: _zoneIconSize - 10,
        icon: Zone.iconForZone(zoneAfterAfter),
        color: zoneAfter == 4
            ? Interface.dark.withOpacity(0.5)
            : zoneAfter == 3
                ? Interface.light.withOpacity(0.5)
                : Interface.alwaysDark.withOpacity(0.5),
        background: Zone.colorForZone(zoneAfterAfter).withOpacity(0.25),
      ),
    ]);
  }

  Widget _buildWidgets() {
    _getData();
    return Dismissible(
        key: Key(widget.index.toString()),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ActivityEditLogs(
                      animalId: widget.animal.id,
                      reserveId: widget.reserveId,
                      callback: () {},
                      fromTrophyLodge: false,
                    )),
          );
          return false;
        },
        background: Container(
            alignment: Alignment.centerLeft,
            color: Interface.dark,
            child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SvgPicture.asset(
                  "assets/graphics/icons/edit.svg",
                  height: _editIconSize,
                  width: _editIconSize,
                  alignment: Alignment.centerLeft,
                  colorFilter: ColorFilter.mode(
                    Interface.light,
                    BlendMode.srcIn,
                  ),
                ))),
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityDetailAnimal(animalId: widget.animal.id)));
            },
            child: Container(
                height: _getSize(),
                padding: const EdgeInsets.only(left: 30, right: 30),
                color: Utils.background(widget.index),
                child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(children: [
                            AutoSizeText(
                              widget.animal.level.toString(),
                              maxLines: 1,
                              style: Interface.s18w500n(Interface.dark),
                            ),
                            Expanded(
                                child: Container(
                                    padding: const EdgeInsets.only(left: 15, right: 30),
                                    child: AutoSizeText(
                                      widget.animal.getNameBasedOnReserve(context.locale, widget.reserveId),
                                      textAlign: TextAlign.start,
                                      maxLines: widget.animal.getNameBasedOnReserve(context.locale, widget.reserveId).split(" ").length == 1 ? 1 : 2,
                                      style: Interface.s16w300n(Interface.dark),
                                    )))
                          ]))),
                  HelperLoadout.isLoadoutActivated
                      ? Container(
                          width: _loadoutIconSize,
                          padding: const EdgeInsets.all(0),
                          child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                            (HelperLoadout.loadoutMin <= widget.animal.level && widget.animal.level <= HelperLoadout.loadoutMax)
                                ? Container(
                                    padding: EdgeInsets.only(bottom: (HelperLoadout.containsCallerForAnimal(widget.animal.id)) ? 3 : 0),
                                    child: SvgPicture.asset(
                                      "assets/graphics/icons/loadout.svg",
                                      width: _loadoutIconSize,
                                      colorFilter: ColorFilter.mode(
                                        Interface.dark,
                                        BlendMode.srcIn,
                                      ),
                                    ))
                                : const SizedBox.shrink(),
                            HelperLoadout.containsCallerForAnimal(widget.animal.id)
                                ? Container(
                                    padding: EdgeInsets.only(
                                        top: (HelperLoadout.loadoutMin <= widget.animal.level && widget.animal.level <= HelperLoadout.loadoutMax) ? 3 : 0),
                                    child: SvgPicture.asset(
                                      "assets/graphics/icons/sense_hearing.svg",
                                      width: _loadoutIconSize,
                                      colorFilter: ColorFilter.mode(
                                        Interface.dark,
                                        BlendMode.srcIn,
                                      ),
                                    ))
                                : const SizedBox.shrink()
                          ]))
                      : const SizedBox.shrink(),
                  AnimatedContainer(
                    width: _zoneIconSize + _zoneIconSize - 5 + _zoneIconSize - 10 + _zoneIconSpace * 2,
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(left: 15),
                    child: _getZones(),
                  )
                ]))));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
