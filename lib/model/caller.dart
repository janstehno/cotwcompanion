// Copyright (c) 2023 Jan Stehno

import 'package:cotwcompanion/model/translatable.dart';
import 'package:easy_localization/easy_localization.dart';

class Caller extends Translatable {
  final int _rangeM;
  final double _rangeYD;
  final int _duration, _strength, _price, _level;
  final int _dlc;

  Caller({
    required super.id,
    required super.en,
    required super.ru,
    required super.cs,
    required super.pl,
    required super.de,
    required super.fr,
    required super.es,
    required super.br,
    required super.ja,
    required super.zh,
    required rangeM,
    required rangeYD,
    required duration,
    required strength,
    required price,
    required level,
    required dlc,
  })  : _rangeM = rangeM,
        _rangeYD = rangeYD,
        _duration = duration,
        _strength = strength,
        _price = price,
        _level = level,
        _dlc = dlc;

  int get strength => _strength;

  int get duration => _duration;

  int get price => _price;

  int get level => _level;

  int get rangeM => _rangeM;

  double get rangeYD => _rangeYD;

  bool get isFromDlc => _dlc == 1;

  bool get hasRequirements => _level > 0;

  String getRange(bool units) => units ? "$_rangeYD ${tr("yards")}" : "$_rangeM ${tr("meters")}";

  factory Caller.fromJson(Map<String, dynamic> json) {
    return Caller(
        id: json['ID'],
        en: json['EN'],
        ru: json['RU'],
        cs: json['CS'],
        pl: json['PL'],
        de: json['DE'],
        fr: json['FR'],
        es: json['ES'],
        br: json['BR'],
        ja: json['JA'],
        zh: json['ZH'],
        rangeM: json['RANGE_M'],
        rangeYD: json['RANGE_YD'],
        duration: json['DURATION'],
        strength: json['STRENGTH'],
        price: json['PRICE'],
        level: json['LEVEL'],
        dlc: json['DLC']);
  }
}
