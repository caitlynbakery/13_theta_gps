import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

part 'theta_event.dart';
part 'theta_state.dart';

class ThetaBloc extends Bloc<ThetaEvent, ThetaState> {
  ThetaBloc() : super(ThetaState.initial()) {
    on<GetGPSPhoneEvent>((event, emit) async {
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();
      String data =
          "Longitude: ${_locationData.longitude} Latitude: ${_locationData.latitude}";

      emit(ThetaState(
          responseWindowState: ResponseWindowState.phoneGPS,
          latitude: _locationData.latitude!));

      print("Longitude: ${_locationData.longitude}");
      print("Latitude: ${_locationData.latitude}");
      print(_locationData.time);
    });
    on<ConvertGPSEvent>((event, emit) async {
      emit(state.copyWith(responseWindowState: ResponseWindowState.convertGPS));
    });
  }
}
