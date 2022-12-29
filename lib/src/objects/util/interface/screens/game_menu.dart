import 'package:flutter/material.dart';
import 'package:restoria/src/views/menu/menu.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 30, color: Colors.white),
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
