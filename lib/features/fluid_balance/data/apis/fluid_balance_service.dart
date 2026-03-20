import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/features/fluid_balance/data/models/add_fluid_balance_command_model.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'fluid_balance_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class FluidBalanceService {
  factory FluidBalanceService(Dio dio, {String baseUrl}) = _FluidBalanceService;

  @POST(ApiConstants.fluidBalance)
  Future<dynamic> postAdmissionsAdmissionidFluidBalance({@Path('admissionId') required String admissionid, @Body() required AddFluidBalanceCommandModel requestBody});

  @GET(ApiConstants.fluidBalance)
  Future<dynamic> getAdmissionsAdmissionidFluidBalance({@Path('admissionId') required String admissionid});

}
