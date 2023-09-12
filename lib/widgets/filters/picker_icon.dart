// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/helpers/filter.dart';
import 'package:cotwcompanion/widgets/switch_icon.dart';
import 'package:cotwcompanion/widgets/title_info_icon.dart';
import 'package:flutter/material.dart';

class FilterPickerIcon extends StatefulWidget {
  final String icon, text;
  final FilterKey filterKey;
  final List<int> values;
  final List<String> icons;
  final List<Color> colors, backgrounds;

  const FilterPickerIcon({
    Key? key,
    required this.icon,
    required this.text,
    required this.filterKey,
    required this.values,
    required this.icons,
    required this.colors,
    required this.backgrounds,
  }) : super(key: key);

  @override
  FilterPickerIconState createState() => FilterPickerIconState();
}

class FilterPickerIconState extends State<FilterPickerIcon> {
  List<Widget> _buildSwitches() {
    List<Widget> switches = [];
    for (int index = 0; index < widget.values.length; index++) {
      int key = widget.values[index];
      switches.add(
        WidgetSwitchIcon(
            buttonSize: 30,
            icon: widget.icons[index],
            activeColor: widget.colors[index],
            activeBackground: widget.backgrounds[index],
            isActive: HelperFilter.getListValue(widget.filterKey, key),
            onTap: () {
              setState(() {
                HelperFilter.switchListValue(widget.filterKey, key);
              });
            }),
      );
    }
    return switches;
  }

  Widget _buildWidgets() {
    return Column(children: [
      WidgetTitleInfoIcon(
        icon: widget.icon,
        text: widget.text,
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: _buildSwitches(),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
