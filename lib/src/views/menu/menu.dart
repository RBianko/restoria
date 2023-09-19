import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restoria/src/objects/util/providers/bgm_manager.dart';
import 'package:restoria/src/views/game/game.dart';

class Menu extends StatelessWidget {
  final bool restart;
  final int? nextLevel;
  const Menu({this.restart = false, this.nextLevel, super.key});

  @override
  Widget build(BuildContext context) {
    SoundEffects.startBgm(BgmType.menu);

    if (restart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navTo(context, const Game());
      });
      return const Center(child: CircularProgressIndicator());
    } else if (nextLevel != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navTo(context, Game(level: nextLevel!));
      });
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.asset('assets/images/ui/bg.gif',
                      fit: BoxFit.fitWidth)),
              Positioned(
                child: Align(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            'The Rest Oria',
                            style: TextStyle(
                              fontSize: 55,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(5, 5),
                                  blurRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        _buildButton(context, 'Start',
                                () => _navTo(context, const Game())),
                        _buildButton(context, 'Settings',
                                () => _navTo(context, const Menu())),
                        _buildButton(context, 'Achievements',
                                () => _navTo(context, const Menu())),
                        _buildButton(context, 'Skins',
                                () => _navTo(context, const Menu())),
                        _buildButton(
                            context, 'Quit', () => SystemNavigator.pop()),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 0,
                child: Text(
                  'v0.0.1 development',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildButton(BuildContext context, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        width: 300,
        height: label == 'Start' ? 50 : 40,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightGreen[900]!),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            style: TextStyle(
              fontSize: label == 'Start' ? 40 : 30,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1, 2),
                  blurRadius: 0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navTo(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
          (Route<dynamic> route) => false,
    );
  }
}
