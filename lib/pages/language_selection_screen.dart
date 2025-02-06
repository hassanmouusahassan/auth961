import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news961/classes/language.dart';
import 'package:news961/classes/language_constants.dart';
import 'package:news961/main.dart';
import 'package:news961/pages/auth/sign_up_page.dart';
import 'package:news961/widgets/language_option_tile.dart';
import 'package:news961/cubits/LanguageSelectionCubit.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
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
    context.read<LanguageSelectionCubit>().loadSelectedLanguage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("omar mab3us deyman bl language ");
    return BlocProvider(
      create: (context) => LanguageSelectionCubit(),
      child: BlocBuilder<LanguageSelectionCubit, LanguageSelectionState>(
        builder: (context, state) {
          final cubit = context.read<LanguageSelectionCubit>();
          final languages = cubit.languages;

          if (state.showOverlay) {
            _controller.forward();
          } else {
            _controller.reverse();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "961",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                if (!state.showOverlay)
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...List.generate(languages.length, (index) {
                            final language = languages[index];
                            final languageNames = [
                              'English',
                              'Français',
                              'عربي'
                            ];
                            return LanguageOptionTile(
                              flagAssetPath:
                                  "assets/flags/${language.flag}.png",
                              languageName: languageNames[index],
                              isSelected: state.selectedLanguageIndex == index,
                              onTap: () {
                                cubit.updateSelectedLanguageIndex(index);
                                cubit.changeLanguage(language, context);
                              },
                            );
                          }),
                          const Spacer(),
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
                                final chosenLang =
                                    languages[state.selectedLanguageIndex];
                                cubit.saveSelectedLanguage(
                                    chosenLang.languageCode);
                                debugPrint(
                                    'Selected Language: ${chosenLang.name}');
                                cubit.showOverlayContainer();
                              },
                              child: Text(
                                translation(context).confirm,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (state.showOverlay)
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
                                  'assets/location.png',
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
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SignUpPage(),
                                        ),
                                      );

                                      Future.delayed(Duration(seconds: 2), () {
                                        cubit.closeOverlay();
                                      });
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
            ),
          );
        },
      ),
    );
  }
}
