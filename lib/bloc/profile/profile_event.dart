import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ProfileGetImageUri extends ProfileEvent {
  final pathFile;

  ProfileGetImageUri(this.pathFile);
}
