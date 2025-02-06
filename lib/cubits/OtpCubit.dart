import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class OtpState {
  final int timer;
  final String phoneNumber;
  final String email;
  final bool showOverlay;

  OtpState({
    this.timer = 30,
    this.phoneNumber = '',
    this.email = '',
    this.showOverlay = false,
  });

  OtpState copyWith({
    int? timer,
    String? phoneNumber,
    String? email,
    bool? showOverlay,
  }) {
    return OtpState(
      timer: timer ?? this.timer,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      showOverlay: showOverlay ?? this.showOverlay,
    );
  }
}

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpState());

  Timer? _timer;

  void startTimer() {
    emit(state.copyWith(timer: 30));
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.timer == 0) {
        timer.cancel();
      } else {
        emit(state.copyWith(timer: state.timer - 1));
      }
    });
  }

  Future<void> loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString('phone_number') ?? '';
    String email = prefs.getString('email') ?? '';
    emit(state.copyWith(phoneNumber: phoneNumber, email: email));
  }

  void showOverlay() {
    emit(state.copyWith(showOverlay: true));
  }

  void hideOverlay() {
    emit(state.copyWith(showOverlay: false));
  }

  void resetTimer() {
    _timer?.cancel();
    emit(state.copyWith(timer: 30));
    startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}