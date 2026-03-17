class ApiConstants {
  static const String baseUrl = "http://cortexaapp.runasp.net";

  // Auth
  static const String login = "/api/Auth/login";
  static const String forgotPassword = "/api/Auth/forgot-password";
  static const String resetPassword = "/api/Auth/reset-password";
  static const String CaseHistory = "/api/admissions/{admissionId}/case-history";
  static const String createPatientOrGetAll = "/api/Patients"; // Assumed

  static const String updateCustomer = "/api/mobile/Customers/UpdateCustomer";
  static String updateCustomerDashboard(String customerId) =>
      "/api/dashboard/Customers/UpdateCustomer/customer/$customerId";
  static String editCustomerStatus(String customerId, bool status) =>
      "/api/dashboard/Customers/EditCustomerStatus/customer/$customerId/status/$status";
  static String deleteAccount(String userId) => "/api/Auth/DeleteUser/$userId";
  static String deleteUser(String userId) => "/api/Auth/DeleteUser/$userId";
  static const String getRoles = "/api/Auth/GetRoles";
  static String createRole(String roleName) =>
      "/api/Auth/CreateRole/roleName/$roleName";
  static String addUserToRole(String userId, String roleName) =>
      "/api/Auth/AddUserToRole/userId/$userId/roleName/$roleName";
  static String getUserBalance(String userId) =>
      "/api/dashboard/Debts/GetUserBalance/user/$userId";

  // Addresses (mobile)
  static const String getCustomerAddresses =
      "/api/mobile/Addresses/GetCustomerAddresses";
  static const String getPrimaryAddress =
      "/api/mobile/Addresses/GetPrimaryCustomerAddress";
  static String markPrimary(String addressId) =>
      "/api/mobile/Addresses/MarkAddressAsPrimary/$addressId";
  static String deleteCustomerAddress(String addressId) =>
      "/api/mobile/Addresses/DeleteCustomerAddress/$addressId";
  static String updateAddress(String addressId) =>
      "/api/mobile/Addresses/UpdateCustomerAddress/$addressId";
  static const String createAddress =
      "/api/mobile/Addresses/CreateCustomerAddress";

  // areas
  static const String getAreas = "/api/dashboard/Areas";
  static String editArea(String areaId) => "/api/dashboard/Areas/$areaId";

  //offers
  static const String offers = "/api/dashboard/Offers";
  static String offersByID(int id) => "/api/dashboard/Offers/$id";

  // CartItems (mobile)
  static const String addProductToCart =
      "/api/mobile/CartItems/AddProductToCart";
  static const String updateCartItemQty =
      "/api/mobile/CartItems/UpdateCartItemQuantity";
  static String deleteCartItem(String productId, int productSe11ingUnitId) =>
      "/api/mobile/CartItems/DeleteCartItem/productId/$productId/productSellingUnitId/$productSe11ingUnitId";

  // Carts (mobile)
  static const String getCartDetails =
      "/api/mobile/Carts/GetCustomerCartDetails";
  static const String addPrescriptionImage =
      "/api/mobile/Carts/AddPrescriptionImage";
  static const String addVoiceRecord = "/api/mobile/Carts/AddVoiceRecord";

  // Products (dashboard) — مؤقتًا لغاية ما يبقى في /mobile
  static const String products = "/api/dashboard/Products";
  static String productById(String id) => "/api/dashboard/Products/$id";
  static const String searchProducts = "/api/mobile/Products/SearchProducts";
  static const String getNewestProducts =
      "/api/mobile/Products/GetNewestProducts";
  static const String getProductSellingUnits =
      "/api/dashboard/ProductSellingUnits";
  static const String postProduct = "/api/dashboard/Products";
  static String updateProduct(int id) =>
      "/api/dashboard/Products/${id.toString()}";
  static String deleteProduct(int id) =>
      "/api/dashboard/Products/${id.toString()}";
  static const String createProductSellingUnit =
      "/api/dashboard/Products/CreateProductSellingUnits";
  static const String updateProductSellingUnit =
      "/api/dashboard/Products/UpdateProductSellingUnits";
  // Selling Units (dashboard)
  static const String getSellingUnits = "/api/dashboard/SellingUnits";
  static const String createSellingUnit = "/api/dashboard/SellingUnits";
  static String updateSellingUnitById(String id) =>
      "/api/dashboard/SellingUnits/$id";
  static String deleteSellingUnitById(String id) =>
      "/api/dashboard/SellingUnits/$id";

  // Categories (dashboard)
  static const String categories = "/api/dashboard/Categories";
  static String categoryById(String id) => "/api/dashboard/Categories/$id";

  // Brands (dashboard)
  static const String brands = "/api/dashboard/Brands";
  static String brandById(String id) => "/api/dashboard/Brands/$id";

  // Advertisements
  static String searchAdvertisements(String name) =>
      "/api/mobile/Advertisements/search/$name";
  static const String advertisements = "/api/dashboard/Advertisements";
  static String advertisementById(int id) =>
      "/api/dashboard/Advertisements/$id";

  // Customers (mobile)
  static const String registerCustomer =
      "/api/mobile/Customers/RegisterCustomer";
  static const String getAllCustomers = "/api/mobile/Customers/GetAllCustomers";
  //Favorites (mobile)
  static const String getFavorites =
      "/api/mobile/Favorites/GetCustomerFavorites";
  static const String addToFavorites =
      "/api/mobile/Favorites/CreateCustomerFavorite";
  static String removeFromFavorites(int productId) =>
      "/api/mobile/Favorites/$productId";

  //Support
  static const String createSupportRequest = "/api/mobile/Supports";

  // Orders (dashbord)
  static const String getOrders = "/api/dashboard/Orders";
  static String getOrderById(int orderId) =>
      "/api/dashboard/Orders/GetOrderById/$orderId";
  static String getOrderByStatus(int status) =>
      "/api/dashboard/Orders/GetOrderByStatus/$status";
  static String updateOrderStatus(int orderId, int status, String notes) =>
      "/api/dashboard/Orders/UpdateOrderStatus/order/$orderId/status/$status/notes/$notes";
  static String addOrderDiscount(int orderId) =>
      "/api/dashboard/Orders/AddOrderDiscount/$orderId";
  static String updateOrderItemQuantity(
    int orderId,
    int productId,
    int quantity,
  ) =>
      "/api/dashboard/Orders/UpdateOrderItemQuantity/order/$orderId/product/$productId/quantity/$quantity";
  static String deleteOrderItem(int orderId, int productId) =>
      "/api/dashboard/Orders/DeleteOrderItem/order/$orderId/product/$productId";

  // Debts (dashboard)
  static const String debts = "/api/dashboard/Debts";
  static const String getAllDebitUsers =
      "/api/dashboard/Debts/GetAllDebitUsers";
  static const String getAllCreditUsers =
      "/api/dashboard/Debts/GetAllCreditUsers";
  static String debtById(int id) => "/api/dashboard/Debts/$id";

  // Notifications (mobile)
  static const String broadcastNotification =
      "/api/mobile/Notifications/broadcast";
  static const String sendToNotificationEntity =
      "/api/dashboard/Notifications/SendToNotificationEntity";
  static const String getUserNotifications =
      "/api/dashboard/Notifications/GetUserNotification";

  // Analysis/Reports (dashboard)
  static String getRevenueByPeriod({String? from, String? to}) {
    final params = <String>[];
    if (from != null) params.add('from=$from');
    if (to != null) params.add('to=$to');
    final query = params.isNotEmpty ? '?${params.join('&')}' : '';
    return "/api/dashboard/Analysis/revenue/period$query";
  }

  static String getDailyRevenue({String? from, String? to}) {
    final params = <String>[];
    if (from != null) params.add('from=$from');
    if (to != null) params.add('to=$to');
    final query = params.isNotEmpty ? '?${params.join('&')}' : '';
    return "/api/dashboard/Analysis/revenue/daily$query";
  }

  static const String getOrderStatusPercentage =
      "/api/dashboard/Analysis/orders/status-percentage";
  static const String getOrderStatusCount =
      "/api/dashboard/Analysis/orders/status-count";
  static const String getSalesSummary = "/api/dashboard/Analysis/sales/summary";
  static String getTopSellingCategories(int top) =>
      "/api/dashboard/Analysis/categories/top-selling?top=$top";
  static const String getProductCount =
      "/api/dashboard/Analysis/products/count";
  static String getLowStockProducts(int threshold) =>
      "/api/dashboard/Products/LowStock?threshold=$threshold";
  static String getBestSellingProducts(int take) =>
      "/api/dashboard/Products/BestSelling?take=$take";
  static String getLowStockCount(int threshold) =>
      "/api/dashboard/Products/LowStock/Count?threshold=$threshold";
  static const String getBestSellingCount =
      "/api/dashboard/Products/BestSelling/Count";

  // ── Case History ───────────────────────────────────────────────────────────
  static const String caseHistory =
      '/api/admissions/{admissionId}/case-history';

  // ── Diagnostics ────────────────────────────────────────────────────────────
  static const String diagnosticsLabOrders = '/api/Diagnostics/lab-orders';
  static const String diagnosticsLabResults = '/api/Diagnostics/lab-results';
  static const String diagnosticsImaging = '/api/Diagnostics/imaging';
  static const String diagnosticsLabOrdersByAdmission =
      '/api/Diagnostics/lab-orders/{admissionId}';
  static const String diagnosticsLabResultsByOrder =
      '/api/Diagnostics/lab-results/{orderId}';
  static const String diagnosticsImagingByAdmission =
      '/api/Diagnostics/imaging/{admissionId}';

  // ── Fluid Balance ──────────────────────────────────────────────────────────
  static const String fluidBalance =
      '/api/admissions/{admissionId}/fluid-balance';

  // ── Intervention Procedures ────────────────────────────────────────────────
  static const String interventionProcedures =
      '/api/admissions/{admissionId}/intervention-procedures';

  // ── Medications ────────────────────────────────────────────────────────────
  static const String admissionMedications =
      '/api/admissions/{admissionId}/medications';

  // ── Nursing Notes ──────────────────────────────────────────────────────────
  static const String nursingNotes =
      '/api/admissions/{admissionId}/nursing-notes';

  // ── Patients ───────────────────────────────────────────────────────────────
  static const String patients = '/api/Patients';
  static const String patientById = '/api/Patients/{id}';
  static const String patientDetails = '/api/Patients/{id}/details';
  static const String patientAdmissions = '/api/Patients/{id}/admissions';

  // ── Physical Examination ───────────────────────────────────────────────────
  static const String physicalExamination =
      '/api/admissions/{admissionId}/physical-examination';

  // ── Vital Signs ────────────────────────────────────────────────────────────
  static const String vitalSigns = '/api/admissions/{admissionId}/vitals';
}
