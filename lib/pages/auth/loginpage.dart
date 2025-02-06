import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news961/pages/auth/sign_up_page.dart';
import 'package:news961/widgets/custom_text_field.dart';
import 'package:news961/classes/language_constants.dart';
import 'package:news961/cubits/LoginCubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _resetPasswordController.dispose();
    super.dispose();
  }

  void _showForgotPasswordModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24.0,
            right: 24.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                translation(context).forgotPassword,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Email Address
              CustomTextField(
                hintText: translation(context).threefields,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 5),

              // Subtitle
              Text(
                translation(context).forgotPasswordSubtitle,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
              const SizedBox(height: 16),

              // Reset Password Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<LoginCubit>().showOverlay();
                  },
                  child: Text(
                    translation(context).resetPassword,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey infoKey1 = GlobalKey();
    final GlobalKey infoKey2 = GlobalKey();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  if (state.showOverlay) {
                    context.read<LoginCubit>().hideOverlay();
                  } else {
                    Navigator.pop(context);
                  }
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
                        // Title
                        Text(
                          translation(context).welcomeback,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Don't have an account? Sign Up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              translation(context).dontHaveAccount,
                              style: const TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Sign Up page
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return const SignUpPage();
                                }));
                              },
                              child: Text(
                                translation(context).signUp,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Email Address
                        CustomTextField(
                          hintText: translation(context).threefields,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        // Password
                        CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: translation(context).password,
                          controller: _passwordController,
                          obscureText: !state.isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context.read<LoginCubit>().togglePasswordVisibility();
                            },
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => _showForgotPasswordModal(context),
                            child: Text(
                              translation(context).forgotPassword,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),

                        // Login Button
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            onPressed: () {
                              // Handle login
                            },
                            child: Text(
                              translation(context).login,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (state.showOverlay)
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Title
                          Text(
                            translation(context).newPassword,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password
                          CustomTextField(
                            keyboardType: TextInputType.visiblePassword,
                            hintText: translation(context).password,
                            controller: _resetPasswordController,
                            obscureText: !state.isPasswordVisible,
                            onChanged: (value) {
                              context.read<LoginCubit>().checkPasswordStrength(value, context);
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                context.read<LoginCubit>().togglePasswordVisibility();
                              },
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Password Strength Indicator
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.passwordStrength,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: state.passwordIndicatorColor,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // Animated Line Indicator
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 5,
                                  width: MediaQuery.of(context).size.width * state.passwordStrengthWidth,
                                  decoration: BoxDecoration(
                                    color: state.passwordIndicatorColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),

                          // Confirm Button
                          SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              onPressed: () {
                                // Handle confirm reset password
                              },
                              child: Text(
                                translation(context).confirm,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (state.showInfoOverlay)
                  Positioned(
                    left: state.infoPosition.dx,
                    top: state.infoPosition.dy,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(horizontal: 24.0),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.infoText,
                            style: const TextStyle(fontSize: 16, color: Colors.black87),
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
                              context.read<LoginCubit>().closeInfoOverlay();
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
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