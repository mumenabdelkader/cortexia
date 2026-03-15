import '../helpers/constants/kconst.dart';
import '../helpers/shared_pref_helper.dart';

class AppCache {
  static Future<void> setFirstTimeOpened() async {
    await SharedPrefHelper.setData(SharedPrefKeys.isFirstTime, false);
  }

  static Future<bool> isFirstTimeOpened() async {
    final value = await SharedPrefHelper.getBool(SharedPrefKeys.isFirstTime);
    return value ?? true;
  }

}
