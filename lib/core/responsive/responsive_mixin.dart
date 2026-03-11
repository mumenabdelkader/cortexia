import 'package:flutter/material.dart';

import '../themes/app_dimens.dart';

/// Mixin to mark widgets that need responsive rebuilding
/// Use this mixin with widgets that use ScreenUtil values
mixin ResponsiveMixin {}

/// Utility class for responsive design helpers
class ResponsiveUtils {
  ResponsiveUtils._();

  /// Get responsive value based on screen size
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (AppDimens.isLargeScreen(context) && desktop != null) {
      return desktop;
    } else if (AppDimens.isMediumScreen(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive padding
  static EdgeInsets responsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    return responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive font size
  static double responsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive spacing
  static double responsiveSpacing(BuildContext context, double baseSpacing) {
    return AppDimens.adaptiveSpacing(context, baseSpacing);
  }

  /// Check if widget should use responsive layout
  static bool shouldUseResponsiveLayout(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  /// Get number of columns for grid based on screen size
  static int getGridColumns(BuildContext context) {
    if (AppDimens.isLargeScreen(context)) return 4;
    if (AppDimens.isMediumScreen(context)) return 3;
    return 2;
  }

  /// Get responsive card width
  static double getResponsiveCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = AppDimens.space16 * 2; // Side paddings

    if (AppDimens.isLargeScreen(context)) {
      return (screenWidth - padding - (AppDimens.space16 * 3)) /
          4; // 4 cards per row
    } else if (AppDimens.isMediumScreen(context)) {
      return (screenWidth - padding - (AppDimens.space16 * 2)) /
          3; // 3 cards per row
    }
    return screenWidth - padding; // Full width on mobile
  }

  /// Calculate responsive aspect ratio
  static double getResponsiveAspectRatio(BuildContext context) {
    if (AppDimens.isLargeScreen(context)) return 16 / 9;
    if (AppDimens.isMediumScreen(context)) return 4 / 3;
    return 3 / 2;
  }

  /// Get orientation-aware spacing
  static double getOrientationAwareSpacing(
    BuildContext context,
    double baseSpacing,
  ) {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return baseSpacing * 0.8; // Reduce spacing in landscape
    }
    return baseSpacing;
  }
}

/// Extension for easier responsive values
extension ResponsiveExtension on BuildContext {
  T responsive<T>({required T mobile, T? tablet, T? desktop}) =>
      ResponsiveUtils.responsive(
        this,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
      );

  bool get isSmallScreen => AppDimens.isSmallScreen(this);
  bool get isMediumScreen => AppDimens.isMediumScreen(this);
  bool get isLargeScreen => AppDimens.isLargeScreen(this);

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
}

/// Performance-optimized container with cached decorations
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxBorder? border;
  final Color? color;
  final BorderRadius? borderRadius;
  final bool enableShadow;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.border,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.enableShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        border: border,
        borderRadius: borderRadius ?? AppDimens.radius12,
        boxShadow:
            enableShadow
                ? [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : null,
      ),
      child: child,
    );
  }
}

/// Responsive text widget that adapts to screen size
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? mobileFontSize;
  final double? tabletFontSize;
  final double? desktopFontSize;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.mobileFontSize,
    this.tabletFontSize,
    this.desktopFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = context.responsive<double?>(
      mobile: mobileFontSize,
      tablet: tabletFontSize,
      desktop: desktopFontSize,
    );

    return Text(
      text,
      style:
          responsiveFontSize != null
              ? (style ?? Theme.of(context).textTheme.bodyMedium)?.copyWith(
                fontSize: responsiveFontSize,
              )
              : style,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

/// Responsive spacing widget
class ResponsiveSpacing extends StatelessWidget {
  final double mobile;
  final double? tablet;
  final double? desktop;
  final bool isHorizontal;

  const ResponsiveSpacing({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.isHorizontal = false,
  });

  const ResponsiveSpacing.horizontal({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : isHorizontal = true;

  const ResponsiveSpacing.vertical({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : isHorizontal = false;

  @override
  Widget build(BuildContext context) {
    final spacing = context.responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );

    return SizedBox(
      width: isHorizontal ? spacing : null,
      height: isHorizontal ? null : spacing,
    );
  }
}

class ExpandableText extends StatefulWidget with ResponsiveMixin {
  final String text;
  final TextStyle? style;
  final int trimLines;
  final double mobileFontSize;
  final double tabletFontSize;
  final double desktopFontSize;
  final String expandText;
  final String collapseText;

  const ExpandableText({
    super.key,
    required this.text,
    this.style,
    this.trimLines = 3,
    this.mobileFontSize = 16,
    this.tabletFontSize = 17,
    this.desktopFontSize = 18,
    this.expandText = "إظهار المزيد",
    this.collapseText = "إظهار أقل",
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          widget.text,
          style: widget.style,
          mobileFontSize: widget.mobileFontSize,
          tabletFontSize: widget.tabletFontSize,
          desktopFontSize: widget.desktopFontSize,
          maxLines: isExpanded ? null : widget.trimLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Text(
            isExpanded ? widget.collapseText : widget.expandText,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
