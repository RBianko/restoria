import 'package:flutter/material.dart';
import 'package:restoria/src/views/menu/menu.dart';

class LevelCompleted extends StatelessWidget {
  const LevelCompleted(this.startBgm, this.level, {Key? key}) : super(key: key);
  final Function startBgm;
  final int level;

  @override
  Widget build(BuildContext context) {
    startBgm('levelCompleted');

    return Positioned(
      top: 50,
      left: MediaQuery.of(context).size.width / 2,
      child: Column(
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
              SizedBox(width: 20),
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
                    'Next Level',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
