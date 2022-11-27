import 'package:dartz/dartz.dart';
import 'package:ecomerce/App/di.dart';
import 'package:ecomerce/Domain/Model/model.dart';

import '../../../Data/Network/failure.dart';
import '../../../Domain/Repositry/repositry.dart';
import '../BaseUseCase.dart';

class AllCatUsecase implements BaseUseCase<String, List<Category>> {
  repositry _repositry;
  AllCatUsecase(this._repositry);

  @override
  Future<Either<Failure, List<Category>>> execute(String empty) {
    return _repositry.allCatRepositry();
  }
}
