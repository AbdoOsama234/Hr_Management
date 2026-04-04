import '../data/models/my_request_model.dart';

abstract class MyRequestsState {}

class MyRequestsInitial extends MyRequestsState {}

class MyRequestsLoading extends MyRequestsState {}

class MyRequestsEmpty extends MyRequestsState {}

class MyRequestsLoaded extends MyRequestsState {
  final List<MyRequestModel> requests;

  MyRequestsLoaded(this.requests);
}
