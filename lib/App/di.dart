import 'package:ecomerce/Data/DataSource/remote_data_source.dart';
import 'package:ecomerce/Data/Network/app_api.dart';
import 'package:ecomerce/Data/Network/dio_factory.dart';
import 'package:ecomerce/Data/Network/network_info.dart';
import 'package:ecomerce/Data/Repositry/repositry_impl.dart';
import 'package:ecomerce/Domain/Repositry/repositry.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../Presentations/Usecases/Cat_usecases/allCat_usecase.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  instance.registerLazySingleton<networkInfo>(
      () => networkInfoImpl(InternetConnectionChecker()));
  //dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  //app service instance
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<appServiceClient>(() => appServiceClient(dio));
  //remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  //repositry instance
  instance.registerLazySingleton<repositry>(
      () => repositryImpl(instance(), instance()));

  //for All Category Usecase instance
  instance.registerFactory<AllCatUsecase>(() => AllCatUsecase(instance()));
}
