import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:restoria/src/objects/util/interface/bars/HP/bars_component.dart';
import 'package:restoria/src/objects/util/interface/menus/hero_menu_controller.dart';

class PlayerHeroInterface extends GameInterface {
  final heroMenu = BonfireInjector().get<HeroMenuController>();
  bool _showMenu = true;

  @override
  void onMount() {
    add(BarsComponent());
    add(InterfaceComponent(
      spriteUnselected: Sprite.load('ui/hero_menu.png'),
      spriteSelected: Sprite.load('ui/hero_menu_pressed.png'),
      size: Vector2(50, 50),
      id: 2,
      position: Vector2(300, 30),
      selectable: false,
      onTapComponent: (selected) => heroMenu.toggle(),
    ));
    add(InterfaceComponent(
      spriteUnselected: Sprite.load('ui/home_button.png'),
      spriteSelected: Sprite.load('ui/home_button_pressed.png'),
      size: Vector2(50, 50),
      id: 3,
      position: Vector2(350, 30),
      selectable: false,
      onTapComponent: (_) {
        _showMenu
            ? gameRef.overlayManager.add('GameMenu')
            : gameRef.overlayManager.remove('GameMenu');
        _showMenu = !_showMenu;
      },
    ));
    super.onMount();
  }

  void _showDialogTest(VoidCallback completed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('AwaitCallbackSceneAction'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      completed();
                    },
                    child: const Text('CONTINUE'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      gameRef.stopScene();
                    },
                    child: const Text('STOP SCENE'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
