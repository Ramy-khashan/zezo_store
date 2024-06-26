import 'package:dartz/dartz.dart';
import '../../../modules/category_products/model/product_model.dart';

abstract class ProductRepository {
  Future<Either<bool, List<ProductModel>>> getProducts(); 
}
