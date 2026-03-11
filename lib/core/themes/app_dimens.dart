import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimens {
  AppDimens._();

  // Static instance
  static AppDimens? _instance;

  // Cache for calculated values
  static final Map<String, double> _cache = {};
  static final Map<String, BorderRadius> _borderRadiusCache = {};
  static final Map<String, EdgeInsets> _paddingCache = {};

  // Initialize once
  static void init() {
    _instance ??= AppDimens._();
    _calculateValues();
  }

  // Calculate all values once and cache them
  static void _calculateValues() {
    _cache["headerHeight"] = 190.h;
    _cache["smallHeaderHeight"] = 118.h;
    _cache["productCardHeight"] = 260.50999450683594.h;
    _cache["productCardWidth"] = 173.2425994873047.w;


    // Spacing values
    _cache['space4'] = 4.h;
    _cache['space8'] = 8.h;
    _cache['space12'] = 12.h;
    _cache['space16'] = 16.h;
    _cache['space20'] = 20.h;
    _cache['space24'] = 24.h;
    _cache['space32'] = 32.h;
    _cache['space72'] = 72.h;

    // Font sizes
    _cache['fontSmall'] = 12.sp;
    _cache['fontMedium'] = 14.sp;
    _cache['fontLarge'] = 16.sp;
    _cache['fontXLarge'] = 18.sp;
    _cache['fontXXLarge'] = 20.sp;
    _cache['fontTitle'] = 24.sp;
    _cache['fontHeading'] = 28.sp;

    // Component dimensions
    _cache['buttonHeight'] = 48.h;
    _cache['textFieldHeight'] = 55.h;
    _cache['bannerHeight'] = 132.h;
    _cache['iconSize'] = 24.sp;
    _cache['iconSizeLarge'] = 32.sp;
    _cache['avatarSize'] = 40.h;

    // Widths
    _cache['buttonWidth'] = 188.w;
    _cache['cardWidth'] = 345.w;
    _cache['imageWidth'] = 123.w;

    // Border radius
    _borderRadiusCache['radius4'] = BorderRadius.circular(4.r);
    _borderRadiusCache['radius8'] = BorderRadius.circular(8.r);
    _borderRadiusCache['radius12'] = BorderRadius.circular(12.r);
    _borderRadiusCache['radius16'] = BorderRadius.circular(16.r);
    _borderRadiusCache['radius20'] = BorderRadius.circular(20.r);
    _borderRadiusCache['radius24'] = BorderRadius.circular(24.r);
    _borderRadiusCache['radius32'] = BorderRadius.circular(32.r);

    // Common padding combinations
    _paddingCache['paddingAll8'] = EdgeInsets.all(8.w);
    _paddingCache['paddingAll12'] = EdgeInsets.all(12.w);
    _paddingCache['paddingAll16'] = EdgeInsets.all(16.w);
    _paddingCache['paddingAll20'] = EdgeInsets.all(20.w);
    _paddingCache['paddingAll24'] = EdgeInsets.all(24.w);

    _paddingCache['paddingH16'] = EdgeInsets.symmetric(horizontal: 16.w);
    _paddingCache['paddingH20'] = EdgeInsets.symmetric(horizontal: 20.w);
    _paddingCache['paddingH24'] = EdgeInsets.symmetric(horizontal: 24.w);

    _paddingCache['paddingV8'] = EdgeInsets.symmetric(vertical: 8.h);
    _paddingCache['paddingV12'] = EdgeInsets.symmetric(vertical: 12.h);
    _paddingCache['paddingV16'] = EdgeInsets.symmetric(vertical: 16.h);

    _paddingCache['paddingH16V8'] = EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);
    _paddingCache['paddingH20V12'] = EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h);
    _paddingCache['paddingH24V16'] = EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h);
  }

  // Clear cache when screen size changes
  static void clearCache() {
    _cache.clear();
    _borderRadiusCache.clear();
    _paddingCache.clear();
  }

  // Getter for header height
  static double get headerHeight => _cache['headerHeight'] ?? 190.0;
  static double get smallHeaderHeight => _cache['smallHeaderHeight'] ?? 118.0;
  static double get productCardHeight => _cache['productCardHeight'] ?? 214.33;
  static double get productCardWidth => _cache['productCardWidth'] ?? 164.0;
  // Getters for spacing
  static double get space4 => _cache['space4'] ?? 4.0;
  static double get space8 => _cache['space8'] ?? 8.0;
  static double get space12 => _cache['space12'] ?? 12.0;
  static double get space16 => _cache['space16'] ?? 16.0;
  static double get space20 => _cache['space20'] ?? 20.0;
  static double get space24 => _cache['space24'] ?? 24.0;
  static double get space32 => _cache['space32'] ?? 32.0;
  static double get space72 => _cache['space72'] ?? 72.0;

  // Getters for font sizes
  static double get fontSmall => _cache['fontSmall'] ?? 12.0;
  static double get fontMedium => _cache['fontMedium'] ?? 14.0;
  static double get fontLarge => _cache['fontLarge'] ?? 16.0;
  static double get fontXLarge => _cache['fontXLarge'] ?? 18.0;
  static double get fontXXLarge => _cache['fontXXLarge'] ?? 20.0;
  static double get fontTitle => _cache['fontTitle'] ?? 24.0;
  static double get fontHeading => _cache['fontHeading'] ?? 28.0;

  // Getters for component dimensions
  static double get buttonHeight => _cache['buttonHeight'] ?? 48.0;
  static double get textFieldHeight => _cache['textFieldHeight'] ?? 55.0;
  static double get bannerHeight => _cache['bannerHeight'] ?? 132.0;
  static double get iconSize => _cache['iconSize'] ?? 24.0;
  static double get iconSizeLarge => _cache['iconSizeLarge'] ?? 32.0;
  static double get avatarSize => _cache['avatarSize'] ?? 40.0;

  // Getters for widths
  static double get buttonWidth => _cache['buttonWidth'] ?? 188.0;
  static double get cardWidth => _cache['cardWidth'] ?? 345.0;
  static double get imageWidth => _cache['imageWidth'] ?? 123.0;

  // Getters for border radius
  static BorderRadius get radius4 => _borderRadiusCache['radius4'] ?? BorderRadius.circular(4);
  static BorderRadius get radius8 => _borderRadiusCache['radius8'] ?? BorderRadius.circular(8);
  static BorderRadius get radius12 => _borderRadiusCache['radius12'] ?? BorderRadius.circular(12);
  static BorderRadius get radius16 => _borderRadiusCache['radius16'] ?? BorderRadius.circular(16);
  static BorderRadius get radius20 => _borderRadiusCache['radius20'] ?? BorderRadius.circular(20);
  static BorderRadius get radius24 => _borderRadiusCache['radius24'] ?? BorderRadius.circular(24);
  static BorderRadius get radius32 => _borderRadiusCache['radius32'] ?? BorderRadius.circular(32);

  // Getters for padding
  static EdgeInsets get paddingAll8 => _paddingCache['paddingAll8'] ?? const EdgeInsets.all(8);
  static EdgeInsets get paddingAll12 => _paddingCache['paddingAll12'] ?? const EdgeInsets.all(12);
  static EdgeInsets get paddingAll16 => _paddingCache['paddingAll16'] ?? const EdgeInsets.all(16);
  static EdgeInsets get paddingAll20 => _paddingCache['paddingAll20'] ?? const EdgeInsets.all(20);
  static EdgeInsets get paddingAll24 => _paddingCache['paddingAll24'] ?? const EdgeInsets.all(24);

  static EdgeInsets get paddingH16 => _paddingCache['paddingH16'] ?? const EdgeInsets.symmetric(horizontal: 16);
  static EdgeInsets get paddingH20 => _paddingCache['paddingH20'] ?? const EdgeInsets.symmetric(horizontal: 20);
  static EdgeInsets get paddingH24 => _paddingCache['paddingH24'] ?? const EdgeInsets.symmetric(horizontal: 24);

  static EdgeInsets get paddingV8 => _paddingCache['paddingV8'] ?? const EdgeInsets.symmetric(vertical: 8);
  static EdgeInsets get paddingV12 => _paddingCache['paddingV12'] ?? const EdgeInsets.symmetric(vertical: 12);
  static EdgeInsets get paddingV16 => _paddingCache['paddingV16'] ?? const EdgeInsets.symmetric(vertical: 16);

  static EdgeInsets get paddingH16V8 => _paddingCache['paddingH16V8'] ??
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static EdgeInsets get paddingH20V12 => _paddingCache['paddingH20V12'] ??
      const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  static EdgeInsets get paddingH24V16 => _paddingCache['paddingH24V16'] ??
      const EdgeInsets.symmetric(horizontal: 24, vertical: 16);

  // Responsive breakpoints
  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.height < 650;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 900;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  // Adaptive values based on screen size
  static double adaptiveCardWidth(BuildContext context) {
    if (isSmallScreen(context)) return cardWidth;
    if (isMediumScreen(context)) return cardWidth * 1.2;
    return cardWidth * 1.5;
  }

  static double adaptiveSpacing(BuildContext context, double baseSpacing) {
    if (isSmallScreen(context)) return baseSpacing;
    if (isMediumScreen(context)) return baseSpacing * 1.2;
    return baseSpacing * 1.5;
  }
}