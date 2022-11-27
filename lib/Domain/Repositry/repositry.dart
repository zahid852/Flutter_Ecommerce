import 'package:dartz/dartz.dart';
import 'package:ecomerce/Data/Network/failure.dart';
import 'package:flutter/cupertino.dart';

import '../Model/model.dart';

abstract class repositry {
  Future<Either<Failure, List<Category>>> allCatRepositry();
}
