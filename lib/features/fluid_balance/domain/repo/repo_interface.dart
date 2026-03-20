import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/fluid_balance/data/models/add_fluid_balance_command_model.dart';

abstract class FluidBalanceRepoInterface {
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidFluidBalance({required String admissionid, required AddFluidBalanceCommandModel requestBody});
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidFluidBalance({required String admissionid});
}
