import 'package:flutter/material.dart';
import 'package:restoria/src/objects/util/providers/bgm_manager.dart';
import 'package:restoria/src/views/menu/menu.dart';

class LevelCompleted extends StatelessWidget {
  final int level;

  const LevelCompleted(this.level, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SoundEffects.startBgm(BgmType.levelCompleted);

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
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'Level $level Completed!',
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 230,
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
                        'Move to Shop',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
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
                          MaterialPageRoute(builder: (context) => Menu(nextLevel: level + 1)),
                              (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'Next Level',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
