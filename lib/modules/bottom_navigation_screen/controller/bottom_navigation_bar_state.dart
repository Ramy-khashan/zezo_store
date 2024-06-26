part of 'bottom_navigation_bar_cubit.dart';

abstract class BottomNavigationBarState extends Equatable {
  const BottomNavigationBarState();

  @override
  List<Object> get props => [];
}

class BottomNavigationBarInitial extends BottomNavigationBarState {}
class ChangePagesState extends BottomNavigationBarState {}
class GetUserDataState extends BottomNavigationBarState {}
class GetCartLengthState extends BottomNavigationBarState {}
