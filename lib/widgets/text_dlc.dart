// Copyright (c) 2022 - 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetTextDlc extends StatelessWidget {
  final String text, subText;
  final bool dlc;

  const WidgetTextDlc({
    Key? key,
    required this.text,
    this.subText = "",
    required this.dlc,
  }) : super(key: key);

  Widget _buildWidgets() {
    return Container(
        child: dlc
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: AutoSizeText(
                            text,
                            maxLines: 1,
                            style: Interface.s16w300n(Interface.dark),
                          ))),
                  Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Interface.primary,
                        border: Border.all(
                          color: Interface.accentBorder,
                          width: Interface.accentBorderWidth,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ))
                ]),
                subText.isNotEmpty
                    ? SizedBox(
                        height: 20,
                        child: AutoSizeText(
                          subText,
                          maxLines: 1,
                          style: Interface.s12w300n(Interface.disabled),
                        ))
                    : const SizedBox.shrink()
              ])
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AutoSizeText(
                  text,
                  maxLines: 1,
                  style: Interface.s16w300n(Interface.dark),
                ),
                subText.isNotEmpty
                    ? SizedBox(
                        height: 20,
                        child: AutoSizeText(
                          subText,
                          maxLines: 1,
                          style: Interface.s12w300n(Interface.disabled),
                        ))
                    : const SizedBox.shrink(),
              ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
