import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpState {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;
  final String selectedCountryCode;
  final String passwordStrength;
  final double passwordStrengthWidth;
  final Color passwordIndicatorColor;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  SignUpState({
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.selectedCountryCode = "LB +961",
    this.passwordStrength = '',
    this.passwordStrengthWidth = 0.0,
    this.passwordIndicatorColor = Colors.transparent,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? password,
    String? confirmPassword,
    String? selectedCountryCode,
    String? passwordStrength,
    double? passwordStrengthWidth,
    Color? passwordIndicatorColor,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      passwordStrengthWidth: passwordStrengthWidth ?? this.passwordStrengthWidth,
      passwordIndicatorColor: passwordIndicatorColor ?? this.passwordIndicatorColor,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }
}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  void updateFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void updateLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void updatePhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    _checkPasswordStrength(password);
    emit(state.copyWith(password: password));
  }

  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void updateSelectedCountryCode(String selectedCountryCode) {
    emit(state.copyWith(selectedCountryCode: selectedCountryCode));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void _checkPasswordStrength(String password) {
    String passwordStrength = '';
    double passwordStrengthWidth = 0.0;
    Color passwordIndicatorColor = Colors.transparent;

    if (password.isEmpty) {
      passwordStrength = '';
      passwordStrengthWidth = 0.0;
      passwordIndicatorColor = Colors.transparent;
    } else if (password.length < 6) {
      passwordStrength = 'Weak';
      passwordStrengthWidth = 0.25;
      passwordIndicatorColor = Colors.red;
    } else if (password.length < 10) {
      passwordStrength = 'Medium';
      passwordStrengthWidth = 0.55;
      passwordIndicatorColor = Colors.orange;
    } else {
      passwordStrength = 'Strong';
      passwordStrengthWidth = 1.0;
      passwordIndicatorColor = Colors.green;
    }

    emit(state.copyWith(
      passwordStrength: passwordStrength,
      passwordStrengthWidth: passwordStrengthWidth,
      passwordIndicatorColor: passwordIndicatorColor,
    ));
  }

  bool isFormValid() {
    return state.firstName.isNotEmpty &&
        state.lastName.isNotEmpty &&
        state.phoneNumber.isNotEmpty &&
        state.email.isNotEmpty &&
        state.password.isNotEmpty &&
        state.confirmPassword.isNotEmpty &&
        state.password == state.confirmPassword;
  }

  Future<void> saveSignUpInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', state.firstName);
    await prefs.setString('last_name', state.lastName);
    await prefs.setString('phone_number', state.phoneNumber);
    await prefs.setString('email', state.email);
    await prefs.setString('password', state.password);
  }
}