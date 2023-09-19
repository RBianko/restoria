import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'bars_controller.dart';

class BarsComponent extends InterfaceComponent
    with UseStateController<BarsController> {
  final double padding = 20;
  final double widthBarLife = 172;
  final double widthBarMana = 148;
  final double strokeWidth = 4;
  double xBarOffset = 67;
  double yHpBarOffset = 16;
  double yMpBarOffset = 36;
  double yExpBarOffset = 66;

  BarsComponent()
      : super(
          id: 1,
          position: Vector2(20, 20),
          spriteUnselected: Sprite.load('ui/health_ui.png'),
          size: Vector2(280, 110),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    try {
      _drawLife(canvas);
      _drawMana(canvas);
      // _drawLevel(canvas);
    } catch (e) {
      print(e);
    }
  }

  void _drawLife(Canvas canvas) {
    double xBar = position.x + xBarOffset;
    double yBar = position.y + yHpBarOffset;
    double currentBarLife =
        (controller.life * widthBarLife) / controller.maxLife;
    double currentPercent = controller.life / (controller.maxLife / 100);

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentPercent)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
    if (currentBarLife > 0) {
      canvas.drawLine(
          Offset(xBar, yBar + 3),
          Offset(xBar + currentBarLife - 4, yBar + 3),
          Paint()
            ..color = _getColorLife(currentPercent)
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.fill);
      canvas.drawLine(
          Offset(xBar, yBar + 6),
          Offset(xBar + currentBarLife - 8, yBar + 6),
          Paint()
            ..color = _getColorLife(currentPercent)
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.fill);
    }
  }

  void _drawMana(Canvas canvas) {
    double xBar = position.x + xBarOffset;
    double yBar = position.y + yMpBarOffset;
    double currentBarMana =
        (controller.stamina * widthBarMana) / controller.maxStamina;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarMana, yBar),
        Paint()
          ..color = Colors.blueAccent
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
    if (currentBarMana > 0) {
      canvas.drawLine(
          Offset(xBar, yBar + 3),
          Offset(xBar + currentBarMana - 4, yBar + 3),
          Paint()
            ..color = Colors.blueAccent
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.fill);
      canvas.drawLine(
          Offset(xBar, yBar + 6),
          Offset(xBar + currentBarMana - 8, yBar + 6),
          Paint()
            ..color = Colors.blueAccent
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.fill);
    }
  }

  // void _drawLevel(Canvas canvas) {
  //   double xBar = position.x + 1;
  //   double yBar = position.y + 1;
  //
  //   double xExpBar = position.x + 1;
  //   double yExpBar = position.y + 1;
  //   double currentBarExp =
  //       (controller.stamina * widthBarMana) / controller.maxStamina;
  //
  //   canvas.drawLine(
  //       Offset(xExpBar, yExpBar),
  //       Offset(xExpBar + currentBarExp, yExpBar),
  //       Paint()
  //         ..color = Colors.deepPurpleAccent
  //         ..strokeWidth = strokeWidth
  //         ..style = PaintingStyle.fill);
  // }

  Color _getColorLife(double currentBarLife) {
    late int red = min(255, ((255 / currentBarLife) * 20).toInt());
    late int green = min(255, (currentBarLife + currentBarLife * 2.55).toInt());
    return Color.fromARGB(255, red, green, 55);
  }
}
