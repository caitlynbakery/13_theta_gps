// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'theta_bloc.dart';

class ThetaState extends Equatable {
  final String gpsInfo;
  const ThetaState(
    this.gpsInfo,
  );

  factory ThetaState.initial() => ThetaState("");

  @override
  List<Object> get props => [gpsInfo];

  ThetaState copyWith({
    String? gpsInfo,
  }) {
    return ThetaState(
      gpsInfo ?? this.gpsInfo,
    );
  }

  @override
  bool get stringify => true;
}
