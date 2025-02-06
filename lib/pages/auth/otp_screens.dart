import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news961/pages/auth/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinput/pinput.dart';
import 'package:news961/classes/language_constants.dart';
import 'package:news961/cubits/OtpCubit.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    context.read<OtpCubit>().loadUserInfo();
    context.read<OtpCubit>().startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  String _parseUsername(String email) {
    return email.split('@').first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit()..loadUserInfo()..startTimer(),
      child: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, state) {
          final username = _parseUsername(state.email);

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                "961",
                style: TextStyle(
                    color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                if (!state.showOverlay)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          translation(context).verifyYourPhoneNumber,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${translation(context).enterOtpSentTo} ${state.phoneNumber}',
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 16),
                        Pinput(
                          length: 4,
                          controller: _otpController,
                          onChanged: (value) {
                            // Handle OTP input change
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          onPressed: () {
                            context.read<OtpCubit>().showOverlay();
                          },
                          child: Text(
                            translation(context).verify,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (state.timer > 0)
                          Text(
                            '${translation(context).resendCodeIn} ${state.timer} ${translation(context).seconds}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          )
                        else
                          TextButton(
                            onPressed: () {
                              context.read<OtpCubit>().resetTimer();
                            },
                            child: Text(
                              translation(context).resendCode,
                              style: const TextStyle(fontSize: 14, color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (state.showOverlay)
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Text(
                                translation(context).welcome,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '@$username',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 9),
                              Text(
                                translation(context).dontMissOut,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.info, color: Colors.red),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        translation(context).infoText,
                                        style: const TextStyle(fontSize: 14, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                  },
                                  child: Text(
                                    translation(context).getStarted,
                                    style: const TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}