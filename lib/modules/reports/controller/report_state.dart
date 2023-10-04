part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class StartUploadReporState extends ReportState {}

class SuccessUploadReporState extends ReportState {}

class FaildUploadReporState extends ReportState {
  final String error;

  const FaildUploadReporState({required this.error});
}
