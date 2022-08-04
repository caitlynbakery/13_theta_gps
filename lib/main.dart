import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'get GPS',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(202, 173, 239, 100)),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'convert GPS',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(202, 173, 239, 100)),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'set GPS',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(173, 239, 192, 100)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'take pic',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(173, 239, 192, 100)),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'save image',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(239, 173, 221, 100)),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'check metadata',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(202, 173, 239, 100)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.asset('assets/images/key.png'),
          )
        ],
      )),
    );
  }
}
