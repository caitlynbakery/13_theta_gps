part of 'theta_bloc.dart';

abstract class ThetaEvent extends Equatable {
  const ThetaEvent();

  @override
  List<Object> get props => [];
}

class GetGPSPhoneEvent extends ThetaEvent {}

class ConvertGPSEvent extends ThetaEvent {}
