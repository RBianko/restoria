import 'package:bonfire/bonfire.dart';

class HeroMenuController extends StateController {
  bool _show = false;
  bool _isVisible = false;
  bool get show => _show;
  bool get isVisible => _isVisible;

  set isVisible(state) => _isVisible = state;

  void toggle() {
    _show = !_show;
    notifyListeners();
  }

  @override
  void update(double dt, GameComponent component) {}
}
