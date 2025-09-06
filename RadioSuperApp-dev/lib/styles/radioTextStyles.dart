import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../configs/theme/appColors.dart';

class RadioTextStyles {
  // Main title text style (e.g., "Search" title)
  static TextStyle interTitleTextStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: AppColors.grayBg,
      fontSize: 23,
      fontWeight: FontWeight.w800,
    ),
  );

  // Subtitle text style (e.g., "Recent searches" title)
  static TextStyle interSubtitleTextStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: AppColors.grayBg,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextStyle bottomBarTextStyle = GoogleFonts.inter(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w800,
      )
  );

  // Category text style (e.g., "SPORTS")
  static TextStyle interCategoryTextStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: AppColors.grayBg,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );

  // Title of each recent search item (e.g., "Consider This")
  static TextStyle interItemTitleTextStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: AppColors.grayBg,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
  );

  // Subtitle for episode count (e.g., "90 episodes")
  static TextStyle interEpisodeTextStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: AppColors.grayBg,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  // Hint text style (e.g., placeholder in the search bar)
  static TextStyle interHintTextStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
      color: AppColors.grayBg,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}
