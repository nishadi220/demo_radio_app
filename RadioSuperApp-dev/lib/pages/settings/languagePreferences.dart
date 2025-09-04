import 'package:flutter/material.dart';
import 'package:radio_super_app/components/common/futureBuilderWidget.dart';
import 'package:radio_super_app/components/radioAppBar.dart';
import 'package:radio_super_app/managers/sharedPreferencesManager.dart';
import 'package:radio_super_app/models/language/entities/languageEntity.dart';
import 'package:radio_super_app/services/settingsService.dart';
import '../../models/language/entities/LanguageListWithSelectedEntity.dart';
import '../../models/language/entities/UpdateUserAndGuestLanguageEntity.dart';
import '../../models/notification/entities/updateUserAndGuestLanguageEntity.dart';

class LanguagePreferencesScreen extends StatefulWidget {
  const LanguagePreferencesScreen({super.key});

  @override
  State<LanguagePreferencesScreen> createState() =>
      _LanguagePreferencesScreenState();
}

class _LanguagePreferencesScreenState extends State<LanguagePreferencesScreen> {
  Future<LanguageListWithSelectedEntity>? _languageFuture;
  String? selectedLanguage;
  bool isHovered = false; // Hover state for Save button
  bool isSaved = false; // Save state for Save button
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _languageFuture = SettingsService().fetchLanguagesAndSelectedLanguage().then((response) {
      setState(() {
        selectedLanguage = response.selectedLanguage.name; // Set selected language before UI builds
      });
      return response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RadioAppBar(context, Colors.black),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Language Preferences',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Choose a language to see more related content',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            FutureBuilderWidget<LanguageListWithSelectedEntity>(
              future: SettingsService().fetchLanguagesAndSelectedLanguage(),
              onSuccess: (responses) {
                // Extract the responses
                final languages = responses.languageList;
                final selectedLanguageResponse = responses.selectedLanguage;

                // Set the initially selected language if it exists
                if (selectedLanguage == null && selectedLanguageResponse.name != null) {
                    selectedLanguage = selectedLanguageResponse.name;
                }

                return Column(
                  children: languages.languages.map((language) {
                    return Column(
                      children: [
                        _buildLanguageButton(language.name),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                );
              },
              onError: (error) {
                return const Center(
                  child: Text(
                    'Failed to load languages. Please try again later.',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
            ),
            const Spacer(),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String language) {
    return GestureDetector(
      onTap: selectedLanguage == language
          ? null // Disable the button if no changes
          :() {
        setState(() {
          selectedLanguage = language; // Update the selected language
          isSaved = false; // Reset save state when a new language is selected
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: selectedLanguage != language
              ? Colors.grey // Disabled state
              : (isSaved ? Colors.cyan[800] : Colors.cyan[800]), // Dynamic color
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            language,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: isSaving ? null : _saveLanguagePreference, // Disable button when saving
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSaving
                ? Colors.grey // Show grey when saving
                : (isSaved ? Colors.cyan[600] : Colors.cyan[800]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: isSaving
                ? const CircularProgressIndicator(color: Colors.white) // Show loading spinner
                : const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveLanguagePreference() async {
    if (selectedLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a language!'),
        ),
      );
      return;
    }

    setState(() {
      isSaving = true; // Start loading state
    });

    final success = await _updateLanguagePreference(selectedLanguage!);

    setState(() {
      isSaving = false; // Stop loading state
      isSaved = success; // Update save status
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? 'Language preferences saved: $selectedLanguage'
            : 'Failed to save language preferences. Please try again.'),
      ),
    );

    if (success) {
      // Reset Save button state after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            isSaved = false;
          });
        }
      });
    }
  }

  Future<bool> _updateLanguagePreference(String language) async {
    // int _mapLanguageToId(String language) {
    //   const languageMap = {
    //     'English': 1,
    //     'Sinhala': 2,
    //     'Tamil': 3,
    //   };
    //   return languageMap[language] ?? -1; // Return -1 if the language is not found
    // }

    try {
      // Retrieve values from SharedPreferences
      final userId = await SharedPreferencesManager().getUserId();
      final guestId = await SharedPreferencesManager().getDeviceId();
      final updatedBy = await SharedPreferencesManager().getDeviceId();

      // Map the selected language name to a language ID
      // final languageId = _mapLanguageToId(language);

      // Validate required values
      if (userId == null || guestId == null || updatedBy == null) {
        print('Error: Missing required fields.');
        return false;
      }

      // Get languageId dynamically from the stored API response
      final languageData = await _languageFuture;
      final selectedLanguageData = languageData!.languageList.languages.firstWhere(
            (lang) => lang.name == language,
        orElse: () => LanguageEntity(id: -1, name: ''), // Return null if not found
      );

      if (selectedLanguageData == -1) {
        print('Error: Selected language not found in API response.');
        return false;
      }

      final languageId = selectedLanguageData.id; // Get the correct ID

      // Create the entity
      final updateUserAndGuestLanguageEntity = UpdateUserAndGuestLanguageEntity(
        userId: userId,
        guestId: guestId,
        languageId: languageId,
        updatedBy: updatedBy,
      );

      // Call the API
      final result = await SettingsService().updateUserAndGuestLanguage(
          updateUserAndGuestLanguageEntity: updateUserAndGuestLanguageEntity,
      );

      return result != null; // Return true if the API call succeeded
    } catch (e) {
      print('Error updating language preference: $e');
      return false; // Return false if an error occurred
    }
  }
}
