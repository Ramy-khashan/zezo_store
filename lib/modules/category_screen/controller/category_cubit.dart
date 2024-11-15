import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/api/exceptions.dart';

import '../../../core/constants/firestore_keys.dart';
import '../model/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
    CategoryCubit(this.dio) : super(CategoryInitial());
    final DioConsumer dio;
    static CategoryCubit get(context) => BlocProvider.of(context);
    List<CategoryModel> category = [];
    getCategory() async {
      category = [];
      emit(LoadingCategoryState());

      try {
        final res =
            await dio.get("${EndPoints.firestoreBaseUrl}/${FirestoreKeys.category}");
        for (var element in List.from(res["documents"])) {
          category.add(CategoryModel.fromJson(element));
        }
        emit(ScuessCategoryState());
      } catch (error) {
        // ignore: deprecated_member_use
        if (error is DioError) {
          emit(FaildCategoryState(
              error: ServerException(error.toString()).message!));
        } else {}
      }
    }
}
