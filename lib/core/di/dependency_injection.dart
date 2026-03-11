import 'package:get_it/get_it.dart';


import '../api_helper/api_helper.dart';
import '../api_helper/dio_helper.dart';

final GetIt locator = GetIt.instance;

Future<void> setupGetIt() async {
  /* ------------------------------ CORE ---------------------------------- */

  locator.registerLazySingleton<ApiHelper>(() => DioHelper());


}
