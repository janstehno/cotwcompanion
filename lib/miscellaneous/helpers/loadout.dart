// Copyright (c) 2023 Jan Stehno

import 'dart:convert';

import 'package:cotwcompanion/miscellaneous/helpers/json.dart';
import 'package:cotwcompanion/miscellaneous/interface/logger.dart';
import 'package:cotwcompanion/miscellaneous/interface/utils.dart';
import 'package:cotwcompanion/miscellaneous/interface/values.dart';
import 'package:cotwcompanion/model/ammo.dart';
import 'package:cotwcompanion/model/idtoid.dart';
import 'package:cotwcompanion/model/loadout.dart';

class HelperLoadout {
  static final HelperLogger _logger = HelperLogger.loadingLoadouts();

  static late Loadout _lastRemovedLoadout;

  static final List<Loadout> _loadouts = [];
  static final Loadout _defaultLoadout = Loadout();

  static Loadout _activeLoadout = _defaultLoadout;

  static int _min = 9;
  static int _max = 1;

  static List<Loadout> get loadouts => _loadouts;

  static Loadout get activeLoadout => _activeLoadout;

  static bool get isLoadoutActivated => _activeLoadout.id > -1;

  static int get loadoutMin => _min;

  static int get loadoutMax => _max;

  static void _reIndex() {
    _loadouts.sort((a, b) => a.name.compareTo(b.name));
    for (Loadout loadout in _loadouts) {
      loadout.setId = _loadouts.indexOf(loadout);
    }
  }

  static void addLoadouts(List<Loadout> loadouts) {
    _loadouts.clear();
    for (Loadout loadout in loadouts) {
      loadout.setAmmo = knownAmmo(loadout);
      loadout.setCallers = knownCallers(loadout);
      _loadouts.add(loadout);
    }
  }

  static List<int> knownAmmo(Loadout loadout) {
    List<int> result = [];
    for (int ammo in loadout.ammo) {
      if (ammo > 0 && ammo <= HelperJSON.ammo.length) result.add(ammo);
    }
    return result;
  }

  static List<int> knownCallers(Loadout loadout) {
    List<int> result = [];
    for (int caller in loadout.callers) {
      if (caller > 0 && caller <= HelperJSON.callers.length) result.add(caller);
    }
    return result;
  }

  static void useLoadout(int loadoutId) {
    if (_loadouts.isNotEmpty && loadoutId > -1) {
      _activeLoadout = _loadouts[loadoutId];
    } else {
      _activeLoadout = _defaultLoadout;
    }
    _loadoutMinMax();
  }

  static bool isActive(int loadoutId) {
    return loadoutId == _activeLoadout.id;
  }

  static void _loadoutMinMax() {
    _min = 9;
    _max = 1;
    if (_activeLoadout.ammo.isNotEmpty) {
      Ammo ammo;
      for (int index in _activeLoadout.ammo) {
        ammo = HelperJSON.getAmmo(index);
        if (_min > ammo.min) _min = ammo.min;
        if (_max < ammo.max) _max = ammo.max;
      }
    }
  }

  static bool containsCallerForAnimal(int animalId) {
    for (IdtoId iti in HelperJSON.animalsCallers) {
      if (iti.firstId == animalId) {
        for (int index in _activeLoadout.callers) {
          if (index == iti.secondId) return true;
        }
      }
    }
    return false;
  }

  static void setLoadouts(List<Loadout> loadouts) {
    _logger.i("Initializing loadouts in HelperLoadout...");
    addLoadouts(loadouts);
    _reIndex();
    _logger.t("Loadouts initialized");
  }

  static void addLoadout(Loadout loadout) {
    _loadouts.add(loadout);
    writeFile();
  }

  static void editLoadout(Loadout loadout) {
    _loadouts[loadout.id] = loadout;
    writeFile();
  }

  static void undoRemove() {
    addLoadout(_lastRemovedLoadout);
  }

  static void removeLoadoutOnIndex(int index) {
    _lastRemovedLoadout = _loadouts.elementAt(index);
    _loadouts.removeAt(index);
    if (_loadouts.isEmpty || _activeLoadout.id == index) {
      useLoadout(-1);
    }
    writeFile();
  }

  static void removeAll() {
    _loadouts.clear();
    writeFile();
  }

  static Future<bool> exportFile() async {
    final String name = "${Utils.dateToString(DateTime.now())}-saved-loadouts-cotwcompanion.json";
    final String content = HelperJSON.listToJson(_loadouts);
    return await Utils.exportFile(content, name);
  }

  static Future<bool> importFile() async {
    return Utils.importFile((content) {
      List<dynamic> data = [];
      try {
        data = json.decode(content) as List<dynamic>;
      } catch (e) {
        return false;
      }
      List<Loadout> loadouts = [];
      try {
        loadouts = data.map((e) => Loadout.fromJson(e)).toList();
      } catch (e) {
        return false;
      }
      if (loadouts.isNotEmpty) {
        addLoadouts(loadouts);
        _reIndex();
        writeFile();
        return true;
      }
      return false;
    });
  }

  static void writeFile() async {
    final String content = parseToJson();
    Utils.writeFile(content, Values.loadouts);
  }

  static Future<List<Loadout>> readFile() async {
    try {
      final data = await Utils.readFile(Values.loadouts);
      final list = json.decode(data) as List<dynamic>;
      final List<Loadout> loadouts = list.map((e) => Loadout.fromJson(e)).toList();
      _logger.t("${loadouts.length} loadouts loaded");
      return loadouts;
    } catch (e) {
      _logger.t("Loadouts not loaded");
      rethrow;
    }
  }

  static parseToJson() {
    return HelperJSON.listToJson(_loadouts);
  }
}
