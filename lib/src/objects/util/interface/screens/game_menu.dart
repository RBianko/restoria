import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:restoria/src/views/menu/menu.dart';

class GameMenu extends StatelessWidget {
  final BonfireGame game;
  const GameMenu(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: const Color.fromRGBO(0, 0, 0, 0.3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Menu',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Menu(restart: true)),
                      );
                    },
                    child: const Text(
                      'Restart',
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Menu()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'Main Menu',
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      game.overlayManager.remove('GameMenu');
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
