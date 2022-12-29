import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'bars_controller.dart';

class Bars extends StatelessWidget {
  const Bars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: StateControllerConsumer<BarsController>(
        builder: (context, controller) {
          return Padding(
            padding: const EdgeInsets.only(left: 30, top: 25),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Text(
                  controller.level.toString(),
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
