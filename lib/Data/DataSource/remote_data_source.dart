import 'package:ecomerce/Domain/Model/model.dart';
import 'package:flutter/material.dart';

import '../Network/app_api.dart';
import '../Responses/responses.dart';

abstract class RemoteDataSource {
  Future<Map<String, CatResponse?>?> allCat();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  appServiceClient _app_service_client;
  RemoteDataSourceImplementer(this._app_service_client);

  @override
  Future<Map<String, CatResponse?>?> allCat() {
    return _app_service_client.AllCat();
  }
}
