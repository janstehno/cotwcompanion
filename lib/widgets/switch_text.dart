// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:flutter/material.dart';

class WidgetSwitchText extends StatelessWidget {
  final String text;
  final Color? color, background, activeColor, activeBackground;
  final double buttonHeight;
  final double? buttonWidth;
  final Function onTap;
  final bool isActive, disabled;

  const WidgetSwitchText({
    Key? key,
    required this.text,
    required this.buttonHeight,
    this.buttonWidth,
    this.color,
    this.background,
    this.activeColor,
    this.activeBackground,
    required this.onTap,
    required this.isActive,
    this.disabled = false,
  }) : super(key: key);

  Widget _buildWidgets() {
    Color actualColor = !disabled && isActive
        ? activeColor ?? Interface.accent
        : !disabled
            ? color ?? Interface.dark.withOpacity(0.3)
            : (color ?? Interface.dark).withOpacity(0.3);
    Color actualBackground = !disabled && isActive
        ? activeBackground ?? Interface.primary
        : !disabled
            ? background ?? Interface.disabled.withOpacity(0.3)
            : (background ?? Interface.disabled).withOpacity(0.3);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      GestureDetector(
          onTap: disabled
              ? () {}
              : () {
                  onTap();
                },
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: buttonHeight,
              width: buttonWidth,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: buttonHeight == buttonWidth ? 0 : 10, right: buttonHeight == buttonWidth ? 0 : 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                color: actualBackground,
              ),
              child: AutoSizeText(
                text,
                maxLines: 1,
                style: buttonHeight <= 25
                    ? Interface.s12w500n(actualColor)
                    : buttonHeight <= 35
                        ? Interface.s14w500n(actualColor)
                        : Interface.s16w500n(actualColor),
              )))
    ]);
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
