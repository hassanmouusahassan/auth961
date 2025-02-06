import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news961/classes/language_constants.dart';

class LoginState {
  final bool isPasswordVisible;
  final bool showOverlay;
  final String passwordStrength;
  final double passwordStrengthWidth;
  final Color passwordIndicatorColor;
  final bool showInfoOverlay;
  final String infoText;
  final Offset infoPosition;

  LoginState({
    this.isPasswordVisible = false,
    this.showOverlay = false,
    this.passwordStrength = '',
    this.passwordStrengthWidth = 0.0,
    this.passwordIndicatorColor = Colors.transparent,
    this.showInfoOverlay = false,
    this.infoText = '',
    this.infoPosition = Offset.zero,
  });

  LoginState copyWith({
    bool? isPasswordVisible,
    bool? showOverlay,
    String? passwordStrength,
    double? passwordStrengthWidth,
    Color? passwordIndicatorColor,
    bool? showInfoOverlay,
    String? infoText,
    Offset? infoPosition,
  }) {
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      showOverlay: showOverlay ?? this.showOverlay,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      passwordStrengthWidth: passwordStrengthWidth ?? this.passwordStrengthWidth,
      passwordIndicatorColor: passwordIndicatorColor ?? this.passwordIndicatorColor,
      showInfoOverlay: showInfoOverlay ?? this.showInfoOverlay,
      infoText: infoText ?? this.infoText,
      infoPosition: infoPosition ?? this.infoPosition,
    );
  }
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void showOverlay() {
    emit(state.copyWith(showOverlay: true));
  }

  void hideOverlay() {
    emit(state.copyWith(showOverlay: false));
  }

  void checkPasswordStrength(String password, BuildContext context) {
    String passwordStrength = '';
    double passwordStrengthWidth = 0.0;
    Color passwordIndicatorColor = Colors.transparent;

    if (password.isEmpty) {
      passwordStrength = '';
      passwordStrengthWidth = 0.0;
      passwordIndicatorColor = Colors.transparent;
    } else if (password.length < 6) {
      passwordStrength = translation(context).weakPassword;
      passwordStrengthWidth = 0.25;
      passwordIndicatorColor = Colors.red;
    } else if (password.length < 10) {
      passwordStrength = translation(context).mediumPassword;
      passwordStrengthWidth = 0.55;
      passwordIndicatorColor = Colors.orange;
    } else {
      passwordStrength = translation(context).strongPassword;
      passwordStrengthWidth = 1.0;
      passwordIndicatorColor = Colors.green;
    }

    emit(state.copyWith(
      passwordStrength: passwordStrength,
      passwordStrengthWidth: passwordStrengthWidth,
      passwordIndicatorColor: passwordIndicatorColor,
    ));
  }

  void showInfo(String infoText, Offset infoPosition) {
    emit(state.copyWith(infoText: infoText, infoPosition: infoPosition, showInfoOverlay: true));
  }

  void closeInfoOverlay() {
    emit(state.copyWith(showInfoOverlay: false));
  }
}