import 'package:dartz/dartz.dart';

import '../../../modules/category_products/model/product_model.dart';
import '../../api/dio_consumer.dart';
import '../../api/end_points.dart';
import '../../constants/firestore_keys.dart';
import 'product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final DioConsumer dio;

  ProductRepositoryImpl({required this.dio});
  @override
  Future<Either<bool, List<ProductModel>>> getProducts() async {
    try {
      List<ProductModel>product=[];
      final res = await dio
          .get("${EndPoints.firestoreBaseUrl}/${FirestoreKeys.proucts}?pageSize=8");
      for (var element in List.from(res["documents"])) {
        product.add(ProductModel.fromJson(element));
      }
      return right(product);
    } catch (e) {
      return left(false);
    }
  } 
}
