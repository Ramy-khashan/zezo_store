import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import '../../api/dio_consumer.dart';
import '../../repository/login/login_repository_impl.dart';
import '../../repository/register/register_repository_impl.dart';

import '../../repository/order_data_repo/order_data_repo_impl.dart';
import '../../repository/products/product_repository_impl.dart';

final serviceLocator = GetIt.instance;
Future<void> locator() async {
  serviceLocator.registerFactory<DioConsumer>(() => DioConsumer(client: Dio()));
  serviceLocator.registerFactory<LoginRepositoryImpl>(
      () => LoginRepositoryImpl(dio: serviceLocator.get<DioConsumer>(),auth: FacebookAuth.i)); 
      serviceLocator.registerFactory<RegisterRepositoryImpl>(
      () => RegisterRepositoryImpl(dio: serviceLocator.get<DioConsumer>()));
        serviceLocator.registerLazySingleton<OrderDataRepoImpl>(
    () => OrderDataRepoImpl(dio: serviceLocator()),
  );  serviceLocator.registerLazySingleton<ProductRepositoryImpl>(
    () => ProductRepositoryImpl(dio: serviceLocator()),
  );
}
