import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theta/theta_bloc.dart';

class ResponseWindow extends StatelessWidget {
  const ResponseWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThetaBloc, ThetaState>(
      builder: (context, state) {
        switch (state.responseWindowState) {
          case ResponseWindowState.initial:
            return Image.asset('assets/images/key.png');
          case ResponseWindowState.phoneGPS:
            return Text(
                "Latitude: ${state.latitude.toString()} Longitude: ${state.longitude.toString()} Time: ${state.time.toString()}");
          case ResponseWindowState.convertGPS:
            return Text(state.dataMap.toString());
          case ResponseWindowState.setGPS:
            return Text("set GPS");
          case ResponseWindowState.getGPS:
            return Text(state.message);
          default:
            return Text("");
        }
      },
    );
  }
}
