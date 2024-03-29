import 'package:flutter/material.dart';
import 'package:restoria/src/views/menu/menu.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Text(
              'Game Over',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
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
                  'Restart',
                  style: TextStyle(fontSize: 30),
                )),
          ),
        ],
      ),
    );
  }
}
