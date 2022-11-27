import 'package:ecomerce/Data/Network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ecomerce/Data/Network/network_info.dart';
import 'package:ecomerce/Domain/Model/model.dart';
import 'package:ecomerce/Domain/Repositry/repositry.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../DataSource/remote_data_source.dart';
import '../Network/error_handler.dart';
import '../Mapper/mappers.dart';

class repositryImpl implements repositry {
  RemoteDataSource _remoteDataSource;
  networkInfo _networkInfo;
  repositryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Category>>> allCatRepositry() async {
    if (await _networkInfo.isConnected()) {
      try {
        final response = await _remoteDataSource.allCat();

        return right(
            response?.entries.map((e) => e.value.toDomain(e.key)).toList() ??
                []);
      } catch (error) {
        return Left(ErrorHandler(error).failure);
      }
    } else {
      return Left(DataSource.NETWORK_ERROR.getFailure());
    }
  }
}
