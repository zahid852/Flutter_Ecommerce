import 'package:ecomerce/App/extention.dart';

import '../../Domain/Model/model.dart';
import '../Responses/responses.dart';

const Empty = '';
const Zero = 0;

extension CatResponseMapper on CatResponse? {
  Category toDomain(String id) {
    return Category(
        id,
        this?.names.orEmpty() ?? Empty,
        this?.des.orEmpty() ?? Empty,
        this?.imageUrl.orEmpty() ?? Empty,
        this?.parameter?.orZero() ?? Zero);
  }
}
