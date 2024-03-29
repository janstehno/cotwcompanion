// Copyright (c) 2023 Jan Stehno

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/widgets/appbar.dart';
import 'package:cotwcompanion/widgets/button_icon.dart';
import 'package:cotwcompanion/widgets/scaffold.dart';
import 'package:cotwcompanion/widgets/title_big.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityAbout extends StatelessWidget {
  final EdgeInsets _padding = const EdgeInsets.all(30);

  const ActivityAbout({
    Key? key,
  }) : super(key: key);

  Widget _buildAbout() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("not_official"),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  tr("about_first_things_first"),
                  style: Interface.s16w300n(Interface.dark),
                )),
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  tr("about_maps"),
                  style: Interface.s16w300n(Interface.dark),
                )),
            Text(
              tr("about_user_interface"),
              style: Interface.s16w300n(Interface.dark),
            ),
          ]))
    ]);
  }

  Widget _buildLanguage() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("language"),
      ),
      Container(
          padding: _padding,
          child: Text(
            tr("about_language"),
            style: Interface.s16w300n(Interface.dark),
          ))
    ]);
  }

  List<Widget> _buildSupportersColumns(List<String> names, Supporter supporter) {
    List<Widget> rows = [];
    for (String name in names) {
      rows.add(AutoSizeText(
        name,
        style: supporter == Supporter.translation ? Interface.s16w300n(Interface.dark) : Interface.s12w300n(Interface.disabled),
        maxLines: 1,
        minFontSize: 4,
      ));
    }
    return rows;
  }

  List<Widget> _buildSupportersRows(Map<String, List<String>> supporters, Supporter supporter) {
    List<Widget> rows = [];
    for (MapEntry<String, List<String>> entry in supporters.entries) {
      rows.add(Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: supporter == Supporter.translation ? 1 : 4,
              child: AutoSizeText(
                entry.key,
                style: supporter == Supporter.translation ? Interface.s14w300n(Interface.disabled) : Interface.s16w300n(Interface.dark),
                maxLines: 1,
                minFontSize: 4,
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _buildSupportersColumns(entry.value, supporter),
              ),
            ),
          ],
        ),
      ));
    }
    return rows;
  }

  Widget _buildSupporters(String title, Map<String, List<String>> supporters, Supporter supporter) {
    return Column(
      children: [
        WidgetTitleBig(
          primaryText: tr(title),
        ),
        Container(
          color: Interface.primary,
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
          child: AutoSizeText(
            tr("${title}_sub"),
            style: Interface.s16w600c(Interface.accent),
            maxLines: 1,
            minFontSize: 4,
          ),
        ),
        Container(
          padding: _padding.subtract(const EdgeInsets.only(bottom: 10)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: _buildSupportersRows(supporters, supporter),
          ),
        ),
      ],
    );
  }

  Widget _buildDonation() {
    return Column(children: [
      WidgetTitleBig(
        primaryText: tr("donation"),
      ),
      Container(
          padding: _padding,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Text(
                  tr("about_donation"),
                  style: Interface.s16w300n(Interface.dark),
                )),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              WidgetButtonIcon(
                buttonSize: 40,
                icon: "assets/graphics/icons/paypal.svg",
                color: Interface.alwaysDark,
                background: Interface.grey,
                onTap: () {
                  Utils.redirectTo("paypal.me", "/toastovac");
                },
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: WidgetButtonIcon(
                    buttonSize: 40,
                    icon: "assets/graphics/icons/coffee.svg",
                    color: Interface.alwaysDark,
                    background: Interface.grey,
                    onTap: () {
                      Utils.redirectTo("buymeacoffee.com", "/toastovac");
                    },
                  )),
              WidgetButtonIcon(
                buttonSize: 40,
                icon: "assets/graphics/icons/patreon.svg",
                color: Interface.alwaysDark,
                background: Interface.grey,
                onTap: () {
                  Utils.redirectTo("patreon.com", "/Toastovac");
                },
              )
            ])
          ]))
    ]);
  }

  Widget _buildFooterLine(String icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 5),
            child: SvgPicture.asset(
              "assets/graphics/icons/$icon.svg",
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(
                Interface.dark,
                BlendMode.srcIn,
              ),
            )),
        SelectableText(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: Interface.s16w300n(Interface.dark),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(children: [
      Expanded(
          child: Container(
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
              alignment: Alignment.center,
              color: Interface.title,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFooterLine("post", Values.email),
                  _buildFooterLine("discord", Values.discord),
                ],
              )))
    ]);
  }

  Widget _buildWidgets(BuildContext context) {
    return WidgetScaffold(
        appBar: WidgetAppBar(
          text: tr("about"),
          context: context,
        ),
        body: Column(children: [
          _buildAbout(),
          _buildLanguage(),
          _buildSupporters("translation_supporters", Values.translationSupporters, Supporter.translation),
          _buildDonation(),
          _buildSupporters("donation_supporters", Values.donationSupporters, Supporter.donation),
          _buildFooter(),
        ]));
  }

  @override
  Widget build(BuildContext context) => _buildWidgets(context);
}
