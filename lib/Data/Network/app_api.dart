import 'package:dio/dio.dart';
import 'package:ecomerce/App/constants.dart';
import 'package:retrofit/retrofit.dart';
import '../Responses/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: constants.baseUrl)
abstract class appServiceClient {
  factory appServiceClient(Dio dio, {String baseUrl}) = _appServiceClient;
  @GET("/category.json")
  Future<Map<String, CatResponse?>?> AllCat();
}
