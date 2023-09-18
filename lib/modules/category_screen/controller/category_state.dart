part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}
class LoadingCategoryState extends CategoryState {}
class ScuessCategoryState extends CategoryState {}
class FaildCategoryState extends CategoryState {
  final String error;

  const FaildCategoryState({required this.error});
}
