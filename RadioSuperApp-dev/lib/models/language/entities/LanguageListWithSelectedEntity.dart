import 'package:radio_super_app/models/language/entities/languageEntity.dart';
import '../responses/getLanguageListResponse.dart';

class LanguageListWithSelectedEntity {
  final GetLanguageListResponse languageList;
  final LanguageEntity selectedLanguage;

  LanguageListWithSelectedEntity(
    {required this.languageList, required this.selectedLanguage}
  );
}