part of 'theta_bloc.dart';

abstract class ThetaEvent extends Equatable {
  const ThetaEvent();

  @override
  List<Object> get props => [];
}

class GetGPSPhoneEvent extends ThetaEvent {}

class SetGPSEvent extends ThetaEvent {}

class GetGPSEvent extends ThetaEvent {}

class TakePicEvent extends ThetaEvent {}

class GetFileEvent extends ThetaEvent {}

class GallerySaveEvent extends ThetaEvent {}

class ImagePickEvent extends ThetaEvent {
  final XFile image;

  const ImagePickEvent(this.image);
}

class GetMetadataEvent extends ThetaEvent {}
