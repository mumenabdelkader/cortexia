import 'dart:convert';

import '../helpers/constants/kconst.dart';
import '../helpers/shared_pref_helper.dart';
import '../../features/authentication/data/models/login_response_model.dart';

class AppCache {
  // ──────────────────────────────────────────────
  //  First-time launch flag
  // ──────────────────────────────────────────────
  static Future<void> setFirstTimeOpened() async {
    await SharedPrefHelper.setData(SharedPrefKeys.isFirstTime, false);
  }

  static Future<bool> isFirstTimeOpened() async {
    final value = await SharedPrefHelper.getBool(SharedPrefKeys.isFirstTime);
    return value ?? true;
  }

  // ──────────────────────────────────────────────
  //  Auth Session
  // ──────────────────────────────────────────────

  /// Saves token to SecureStorage and the rest of [data] as JSON to SharedPrefs.
  static Future<void> saveUserData(UserData data) async {
    // Token goes to secure storage
    if (data.token != null) {
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.userToken,
        data.token!,
      );
    }

    // Rest of user info saved as JSON
    final map = {
      'email': data.email,
      'userId': data.userId,
      'userIdInSystem': data.userIdInSystem,
      'roles': data.roles,
    };
    await SharedPrefHelper.setData(
      SharedPrefKeys.userDataJson,
      jsonEncode(map),
    );
  }

  /// Returns true if a token is saved (user is logged in).
  static Future<bool> isLoggedIn() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    return token.isNotEmpty;
  }

  /// Returns the saved JWT token, or an empty string.
  static Future<String> getToken() async {
    return SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  }

  /// Returns the saved user data as a [UserData] object, or null.
  static Future<UserData?> getUserData() async {
    final raw = SharedPrefHelper.getStringSync(SharedPrefKeys.userDataJson);
    if (raw.isEmpty) return null;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    return UserData(
      token: token,
      email: map['email'] as String?,
      userId: map['userId'] as String?,
      userIdInSystem: map['userIdInSystem'] as String?,
      roles: (map['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  /// Clears all saved auth data (call on logout).
  static Future<void> clearUserData() async {
    await SharedPrefHelper.clearAllSecuredData();
    await SharedPrefHelper.removeData(SharedPrefKeys.userDataJson);
  }
}
