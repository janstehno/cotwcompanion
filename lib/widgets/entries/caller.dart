// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/activities/detail/caller.dart';
import 'package:cotwcompanion/miscellaneous/interface/graphics.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/settings.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/model/caller.dart';
import 'package:cotwcompanion/widgets/entries/item.dart';
import 'package:cotwcompanion/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryCaller extends StatefulWidget {
  final int index;
  final Caller caller;
  final Function callback;

  const EntryCaller({
    Key? key,
    required this.index,
    required this.caller,
    required this.callback,
  }) : super(key: key);

  @override
  EntryCallerState createState() => EntryCallerState();
}

class EntryCallerState extends State<EntryCaller> {
  late final bool _imperialUnits;

  @override
  void initState() {
    _imperialUnits = Provider.of<Settings>(context, listen: false).imperialUnits;
    super.initState();
  }

  List<WidgetTag> _buildTags() {
    List<WidgetTag> tags = [];
    if (widget.caller.isFromDlc) {
      tags.add(WidgetTag.big(
        icon: "assets/graphics/icons/dlc.svg",
        color: Interface.accent,
        background: Interface.primary,
      ));
    }
    tags.addAll([
      WidgetTag.big(
        icon: "assets/graphics/icons/range.svg",
        value: widget.caller.getRange(_imperialUnits),
        color: Interface.dark,
        background: Interface.tag,
      )
    ]);
    return tags;
  }

  Widget _buildWidgets() {
    return GestureDetector(
        onTap: () {
          widget.callback();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityDetailCaller(caller: widget.caller)),
          );
        },
        child: Container(
            padding: const EdgeInsets.all(30),
            color: Utils.background(widget.index),
            child: EntryItem(
              text: widget.caller.getName(context.locale),
              itemIcon: Graphics.getCallerIcon(widget.caller.id),
              tags: _buildTags(),
            )));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
