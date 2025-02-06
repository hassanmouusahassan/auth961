import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news961/cubits/SignUpCubit.dart';
import 'package:news961/pages/auth/loginpage.dart';
import 'package:news961/pages/auth/otp_screens.dart';
import 'package:news961/widgets/custom_text_field.dart';
import 'package:news961/classes/language_constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _capitalizeFirstLetter(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {

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
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title
                        Text(
                          translation(context).signUp,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Already have an account? Log in
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              translation(context).alreadyHaveAccount,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: Text(
                                translation(context).login,
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

                        // Subtitle
                        Text(
                          translation(context).signUpSubtitle,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 16),

                        // First Name and Last Name
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                keyboardType: TextInputType.name,
                                hintText: translation(context).firstName,
                                controller: _firstNameController,
                                onChanged: (value) {
                                  _firstNameController.value =
                                      _firstNameController.value.copyWith(
                                    text: _capitalizeFirstLetter(value),
                                    selection: TextSelection.collapsed(
                                        offset: value.length),
                                  );
                                  context
                                      .read<SignUpCubit>()
                                      .updateFirstName(value);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomTextField(
                                keyboardType: TextInputType.name,
                                hintText: translation(context).lastName,
                                controller: _lastNameController,
                                onChanged: (value) {
                                  _lastNameController.value =
                                      _lastNameController.value.copyWith(
                                    text: _capitalizeFirstLetter(value),
                                    selection: TextSelection.collapsed(
                                        offset: value.length),
                                  );
                                  context
                                      .read<SignUpCubit>()
                                      .updateLastName(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Phone Number
                        Row(
                          children: [
                            DropdownButton<String>(
                              value: state.selectedCountryCode,
                              items: ["LB +961", "US +1", "FR +33"]
                                  .map(
                                    (countryCode) => DropdownMenuItem<String>(
                                      value: countryCode,
                                      child: Text(countryCode),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                context
                                    .read<SignUpCubit>()
                                    .updateSelectedCountryCode(value!);
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomTextField(
                                hintText: translation(context).phoneNumber,
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  context
                                      .read<SignUpCubit>()
                                      .updatePhoneNumber(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Email Address
                        CustomTextField(
                          hintText: translation(context).emailAddress,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            context.read<SignUpCubit>().updateEmail(value);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password
                        CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: translation(context).password,
                          controller: _passwordController,
                          obscureText: !state.isPasswordVisible,
                          onChanged: (value) {
                            context.read<SignUpCubit>().updatePassword(value);
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context
                                  .read<SignUpCubit>()
                                  .togglePasswordVisibility();
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password
                        CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: translation(context).confirmPassword,
                          controller: _confirmPasswordController,
                          obscureText: !state.isConfirmPasswordVisible,
                          onChanged: (value) {
                            context
                                .read<SignUpCubit>()
                                .updateConfirmPassword(value);
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context
                                  .read<SignUpCubit>()
                                  .toggleConfirmPasswordVisibility();
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

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
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 5,
                                width: MediaQuery.of(context).size.width *
                                    state.passwordStrengthWidth,
                                decoration: BoxDecoration(
                                  color: state.passwordIndicatorColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              // Animated Line Indicator
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Sign Up Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          onPressed: () async {
                            if (context.read<SignUpCubit>().isFormValid()) {
                              await context
                                  .read<SignUpCubit>()
                                  .saveSignUpInfo();
                              debugPrint('Sign Up Clicked');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const OtpScreen()));
                            } else {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(translation(context).fillAllFields),
                                ),
                              );
                            }
                          },
                          child: Text(
                            translation(context).signUp,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Terms and Conditions
                      Text(
                        translation(context).termsAndPrivacy,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
