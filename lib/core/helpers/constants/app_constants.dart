class AppConstants {
  AppConstants._();

  // Pagination
  static const int defaultPageSize = 20;
  static const int homePageSize = 10;
  static const int recentProductsLimit = 4;
  static const int popularProductsLimit = 10;

  // Carousel
  static const Duration carouselAutoPlayInterval = Duration(seconds: 3);
  static const Duration carouselAnimationDuration = Duration(milliseconds: 800);

  // Debouncing
  static const Duration searchDebounce = Duration(milliseconds: 500);

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);

  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);
}