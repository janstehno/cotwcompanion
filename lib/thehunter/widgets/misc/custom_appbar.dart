// Copyright (c) 2022 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/helpers/helper_values.dart';
import 'package:cotwcompanion/thehunter/widgets/misc/custom_button.dart';
import 'package:flutter/material.dart';

class WidgetAppBar extends StatelessWidget {
  final String text;
  final int? maxLines;
  final Widget? custom;
  final double height;
  final int? color;
  final int? background;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets? padding;
  final Alignment alignment;
  final Function function;

  const WidgetAppBar(
      {Key? key,
      this.text = "",
      this.maxLines,
      this.custom,
      required this.height,
      this.color,
      this.background,
      required this.fontSize,
      required this.fontWeight,
      this.padding,
      required this.alignment,
      required this.function})
      : super(key: key);

  Widget _buildBackButton() {
    return AnimatedContainer(
        height: height,
        width: 70,
        duration: const Duration(milliseconds: 200),
        color: Color(background ?? Values.colorPrimary),
        child: WidgetButton(
            background: background ?? Values.colorPrimary,
            color: color ?? Values.colorAccent,
            icon: "assets/graphics/icons/back.svg",
            onTap: () {
              function();
            }));
  }

  Widget _buildWidgets() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _buildBackButton(),
      Expanded(
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: height,
              color: Color(background ?? Values.colorPrimary),
              alignment: alignment,
              padding: padding ?? const EdgeInsets.only(right: 30, left: 30),
              child: custom ??
                  AutoSizeText(
                    text,
                    maxLines: maxLines ?? 2,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Color(color ?? Values.colorAccent), fontSize: fontSize, fontWeight: fontWeight),
                  )))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgets();
  }
}
