import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class ProfileState {
  final File? profileImage;
  final String? gender;
  final String? bloodType;
  final String? bloodGroup;
  final DateTime? birthday;
  final bool showInfoOverlay;
  final bool showNextOverlay;
  final String infoText;

  ProfileState({
    this.profileImage,
    this.gender,
    this.bloodType,
    this.bloodGroup,
    this.birthday,
    this.showInfoOverlay = false,
    this.showNextOverlay = false,
    this.infoText = '',
  });

  ProfileState copyWith({
    File? profileImage,
    String? gender,
    String? bloodType,
    String? bloodGroup,
    DateTime? birthday,
    bool? showInfoOverlay,
    bool? showNextOverlay,
    String? infoText,
  }) {
    return ProfileState(
      profileImage: profileImage ?? this.profileImage,
      gender: gender ?? this.gender,
      bloodType: bloodType ?? this.bloodType,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      birthday: birthday ?? this.birthday,
      showInfoOverlay: showInfoOverlay ?? this.showInfoOverlay,
      showNextOverlay: showNextOverlay ?? this.showNextOverlay,
      infoText: infoText ?? this.infoText,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  void updateProfileImage(File profileImage) {
    emit(state.copyWith(profileImage: profileImage));
  }

  void updateGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void updateBloodType(String bloodType) {
    emit(state.copyWith(bloodType: bloodType));
  }

  void updateBloodGroup(String bloodGroup) {
    emit(state.copyWith(bloodGroup: bloodGroup));
  }

  void updateBirthday(DateTime birthday) {
    emit(state.copyWith(birthday: birthday));
  }

  void showInfo(String infoText) {
    emit(state.copyWith(infoText: infoText, showInfoOverlay: true));
  }

  void closeOverlay() {
    emit(state.copyWith(showInfoOverlay: false, showNextOverlay: false));
  }

  void showNextOverlayContainer() {
    emit(state.copyWith(showNextOverlay: true));
  }

  void saveProfileData({
    required File profileImage,
    required String gender,
    required String bloodType,
    required String bloodGroup,
    required DateTime birthday,
  }) {
    emit(ProfileState(
      profileImage: profileImage,
      gender: gender,
      bloodType: bloodType,
      bloodGroup: bloodGroup,
      birthday: birthday,
      showNextOverlay: true,
    ));
  }
}