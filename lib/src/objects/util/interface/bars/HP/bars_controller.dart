import 'package:bonfire/bonfire.dart';

import 'bars_component.dart';

class BarsController extends StateController<BarsComponent> {
  double _maxLife = 100;
  double _maxStamina = 100;
  get maxLife => _maxLife;
  get maxStamina => _maxStamina;

  int _level = 1;
  double _life = 0;
  double _stamina = 0;

  int get level => _level;
  double get life => _life;
  double get stamina => _stamina;

  set level(int newLevel) {
    _level = newLevel;
    notifyListeners();
  }

  set life(double newLife) {
    _life = newLife;
    notifyListeners();
  }

  set stamina(double newStamina) {
    _stamina = newStamina;
    notifyListeners();
  }

  void configure({required double maxLife, required double maxStamina}) {
    _maxLife = maxLife;
    _maxStamina = maxStamina;
  }

  @override
  void update(double dt, BarsComponent component) {}
}
