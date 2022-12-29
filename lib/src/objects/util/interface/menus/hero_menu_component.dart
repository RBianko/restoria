import 'package:bonfire/bonfire.dart';

import 'hero_menu_controller.dart';

class HeroMenuComponent extends InterfaceComponent
    with UseStateController<HeroMenuController> {
  HeroMenuComponent()
      : super(
          id: 4,
          position: Vector2(250, 150),
          spriteUnselected: Sprite.load('ui/menu.png'),
          size: Vector2(300, 390),
        );
}
