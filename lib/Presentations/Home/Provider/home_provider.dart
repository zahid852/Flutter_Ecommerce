import 'package:ecomerce/Data/Mapper/mappers.dart';
import 'package:ecomerce/Domain/Model/model.dart';
import 'package:ecomerce/Presentations/Usecases/Cat_usecases/allCat_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../App/di.dart';

class homeProvider extends ChangeNotifier {
  AllCatUsecase _allCatUsecase = instance<AllCatUsecase>();
  List<Category> _allCatData = [];
  List<Category> get allCategoryData {
    return [..._allCatData];
  }

  Future<void> allCatData() async {
    try {
      (await _allCatUsecase.execute(Empty)).fold((failure) {
        print(failure.code.toString() + " " + failure.message);
        throw failure;
      }, (data) {
        _allCatData = data;
        notifyListeners();
      });
    } catch (error) {
      rethrow;
    }
  }
}
