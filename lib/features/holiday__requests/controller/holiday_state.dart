import '../data/models/holiday_request_model.dart';

abstract class HolidayState {}

class HolidayInitial extends HolidayState {}

class HolidayLoading extends HolidayState {}

class HolidayLoaded extends HolidayState {
  final List<HolidayRequestModel> requests;
  HolidayLoaded(this.requests);
}

class HolidayEmpty extends HolidayState {}
