import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProfileInitialized extends ProfileState {}

class ProfilePickImageSuccess extends ProfileState {
  final pathImage;

  ProfilePickImageSuccess(this.pathImage);

  @override
  List<Object?> get props => [pathImage];
}

class ProfilePickImageFailed extends ProfileState {
  final dynamic error;

  ProfilePickImageFailed(this.error);

  @override
  List<Object> get props => [error];
}
