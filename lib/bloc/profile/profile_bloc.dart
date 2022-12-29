import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/profile/profile_event.dart';
import 'package:vn_crypto/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(ProfileInitialized()) {
    on<ProfileGetImageUri>((event, emit) async {
      emit(ProfilePickImageSuccess(event.pathFile));
    });
  }
}
