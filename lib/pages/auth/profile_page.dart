import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news961/cubits/ProfileCubit.dart';
import 'package:news961/widgets/custom_radio_button.dart';
import 'package:news961/widgets/custom_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news961/classes/language_constants.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      context.read<ProfileCubit>().updateProfileImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
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
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.showNextOverlay) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            return Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Profile Picture Upload
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => _pickImage(context),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[200],
                                      backgroundImage: state.profileImage != null
                                          ? FileImage(state.profileImage!)
                                          : null,
                                      child: state.profileImage == null
                                          ? const Icon(Icons.person,
                                              size: 40, color: Colors.grey)
                                          : null,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton.icon(
                                      onPressed: () => _pickImage(context),
                                      icon: const Icon(Icons.upload,
                                          color: Colors.grey),
                                      label: Text(
                                        translation(context).uploadProfilePic,
                                        style: const TextStyle(color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.info_outline,
                                        color: Colors.grey),
                                    onPressed: () => context.read<ProfileCubit>().showInfo(
                                        translation(context).uploadProfilePicInfo),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Date Picker
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translation(context).birthday,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.info_outline,
                                        color: Colors.grey),
                                    onPressed: () => context.read<ProfileCubit>().showInfo(
                                        translation(context).birthdayInfo),
                                  ),
                                ],
                              ),
                              CustomDatePicker(
                                onDateSelected: (date) {
                                  context.read<ProfileCubit>().updateBirthday(date);
                                },
                              ),
                              const SizedBox(height: 24),

                              // Gender Selection
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translation(context).gender,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.info_outline,
                                        color: Colors.grey),
                                    onPressed: () => context.read<ProfileCubit>().showInfo(
                                        translation(context).genderInfo),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  CustomRadioButton(
                                    label: translation(context).male,
                                    isSelected: state.gender == "Male",
                                    onTap: () {
                                      context.read<ProfileCubit>().updateGender("Male");
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  CustomRadioButton(
                                    label: translation(context).female,
                                    isSelected: state.gender == "Female",
                                    onTap: () {
                                      context.read<ProfileCubit>().updateGender("Female");
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Blood Type Selection
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translation(context).bloodType,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.info_outline,
                                        color: Colors.grey),
                                    onPressed: () => context.read<ProfileCubit>().showInfo(
                                        translation(context).bloodTypeInfo),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: [
                                  CustomRadioButton(
                                    label: "A",
                                    isSelected: state.bloodType == "A",
                                    onTap: () {
                                      context.read<ProfileCubit>().updateBloodType("A");
                                    },
                                  ),
                                  CustomRadioButton(
                                    label: "B",
                                    isSelected: state.bloodType == "B",
                                    onTap: () {
                                      context.read<ProfileCubit>().updateBloodType("B");
                                    },
                                  ),
                                  CustomRadioButton(
                                    label: "AB",
                                    isSelected: state.bloodType == "AB",
                                    onTap: () {
                                      context.read<ProfileCubit>().updateBloodType("AB");
                                    },
                                  ),
                                  CustomRadioButton(
                                    label: "O",
                                    isSelected: state.bloodType == "O",
                                    onTap: () {
                                      context.read<ProfileCubit>().updateBloodType("O");
                                    },
                                  ),
                                  CustomRadioButton(
                                    label: "+ Positive",
                                    isSelected: state.bloodGroup == "+ Positive",
                                    onTap: () {
                                      context.read<ProfileCubit>().updateBloodGroup("+ Positive");
                                    },
                                  ),
                                  CustomRadioButton(
                                    label: "- Negative",
                                    isSelected: state.bloodGroup == "- Negative",
                                    onTap: () {
                                      context.read<ProfileCubit>().updateBloodGroup("- Negative");
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  state.profileImage != null &&
                                  state.gender != null &&
                                  state.bloodType != null &&
                                  state.bloodGroup != null &&
                                  state.birthday != null
                                      ? Colors.red
                                      : Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            onPressed: state.profileImage != null &&
                                    state.gender != null &&
                                    state.bloodType != null &&
                                    state.bloodGroup != null &&
                                    state.birthday != null
                                ? () {
                                    context.read<ProfileCubit>().saveProfileData(
                                      profileImage: state.profileImage!,
                                      gender: state.gender!,
                                      bloodType: state.bloodType!,
                                      bloodGroup: state.bloodGroup!,
                                      birthday: state.birthday!,
                                    );
                                    context.read<ProfileCubit>().showNextOverlayContainer();
                                  }
                                : null,
                            child: const Text(
                              "Next",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.showInfoOverlay)
                  Center(
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
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
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
                              context.read<ProfileCubit>().closeOverlay();
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
                if (state.showNextOverlay)
                  FadeTransition(
                    opacity: _animation,
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: const EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
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
                                Image.asset(
                                  'assets/notification.png',
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  translation(context).title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  translation(context).description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
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
                                      context.read<ProfileCubit>().closeOverlay();
                                    },
                                    child: Text(
                                      translation(context).buttonText,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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