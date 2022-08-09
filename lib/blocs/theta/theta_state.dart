// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'theta_bloc.dart';

enum ResponseWindowState { initial, phoneGPS, convertGPS }

class ThetaState extends Equatable {
  final double latitude;
  final ResponseWindowState responseWindowState;

  const ThetaState(
      {this.latitude = 0.0,
      this.responseWindowState = ResponseWindowState.initial});

  factory ThetaState.initial() => ThetaState();

  @override
  List<Object> get props => [latitude, responseWindowState];

  ThetaState copyWith({
    double? latitude,
    ResponseWindowState? responseWindowState,
  }) {
    return ThetaState(
      latitude: latitude ?? this.latitude,
      responseWindowState: responseWindowState ?? this.responseWindowState,
    );
  }

  @override
  bool get stringify => true;
}
