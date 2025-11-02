import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart';

class FpsMeter extends StatelessWidget {
  FpsMeter({super.key});
  final fps = FpsTextComponent(windowSize: 120);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      right: 20,
      child: Text(
        '${fps.fpsComponent.fps} FPS',
      ),
    );
  }
}
