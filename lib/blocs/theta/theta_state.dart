// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'theta_bloc.dart';

enum ResponseWindowState { initial, phoneGPS, convertGPS, setGPS }

class ThetaState extends Equatable {
  final double latitude;
  final double longitude;
  final double time;
  final double altitude;
  final Map dataMap;
  final String message;
  final ResponseWindowState responseWindowState;

  const ThetaState(
      {this.latitude = 0.0,
      this.longitude = 0.0,
      this.time = 0.0,
      this.altitude = 0.0,
      this.dataMap: const {},
      this.message = "",
      this.responseWindowState = ResponseWindowState.initial});

  factory ThetaState.initial() => ThetaState();

  @override
  List<Object> get props => [
        latitude,
        longitude,
        altitude,
        dataMap,
        message,
        time,
        responseWindowState
      ];

  ThetaState copyWith({
    double? latitude,
    double? longitude,
    double? time,
    double? altitude,
    Map? dataMap,
    String? message,
    ResponseWindowState? responseWindowState,
  }) {
    return ThetaState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      time: time ?? this.time,
      dataMap: dataMap ?? this.dataMap,
      altitude: altitude ?? this.altitude,
      message: message ?? this.message,
      responseWindowState: responseWindowState ?? this.responseWindowState,
    );
  }

  @override
  bool get stringify => true;
}
