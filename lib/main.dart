import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/theta/theta_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThetaBloc(),
      child: MaterialApp(
        home: BlocBuilder<ThetaBloc, ThetaState>(
          builder: (context, state) {
            return Scaffold(
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
                            onPressed: () {
                              context.read<ThetaBloc>().add(GetGPSPhoneEvent());
                            },
                            child: const Text(
                              'get GPS \n phone',
                              style: TextStyle(color: Colors.black87),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(202, 173, 239, 100)),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'convert GPS',
                              style: TextStyle(color: Colors.black87),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(202, 173, 239, 100)),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'set GPS \n camera',
                              style: TextStyle(color: Colors.black87),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(173, 239, 192, 100)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'get GPS \n camera',
                              style: TextStyle(color: Colors.black87),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(173, 239, 192, 100)),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'take pic',
                              style: TextStyle(color: Colors.black87),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(173, 239, 192, 100)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'save image \n phone',
                              style: TextStyle(color: Colors.black87),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(239, 173, 221, 100)),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'check metadata \n file',
                              style: TextStyle(color: Colors.black87),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(202, 173, 239, 100)),
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
            ));
          },
        ),
      ),
    );
  }
}
