import 'package:bloc/bloc.dart';
import 'package:news961/classes/language_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news961/classes/language.dart';
import 'package:flutter/material.dart';
import 'package:news961/main.dart';

class LanguageSelectionState {
  final int selectedLanguageIndex;
  final bool showOverlay;

  LanguageSelectionState({
    this.selectedLanguageIndex = 0,
    this.showOverlay = false,
  });

  LanguageSelectionState copyWith({
    int? selectedLanguageIndex,
    bool? showOverlay,
  }) {
    return LanguageSelectionState(
      selectedLanguageIndex: selectedLanguageIndex ?? this.selectedLanguageIndex,
      showOverlay: showOverlay ?? this.showOverlay,
    );
  }
}

class LanguageSelectionCubit extends Cubit<LanguageSelectionState> {
  LanguageSelectionCubit() : super(LanguageSelectionState());

  final List<Language> _languages = Language.languageList();

  void loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode != null) {
      int index = _languages.indexWhere((lang) => lang.languageCode == languageCode);
      if (index != -1) {
        emit(state.copyWith(selectedLanguageIndex: index));
      }
    }
  }

  void saveSelectedLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
    int index = _languages.indexWhere((lang) => lang.languageCode == languageCode);
    if (index != -1) {
      emit(state.copyWith(selectedLanguageIndex: index));
    }
  }

  void changeLanguage(Language language, BuildContext context) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  void showOverlayContainer() {
    emit(state.copyWith(showOverlay: true));
  }

  void closeOverlay() {
    emit(state.copyWith(showOverlay: false));
  }

  void updateSelectedLanguageIndex(int index) {
    emit(state.copyWith(selectedLanguageIndex: index));
  }

  List<Language> get languages => _languages;
}