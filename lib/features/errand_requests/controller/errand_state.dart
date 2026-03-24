import '../data/models/errand_request_model.dart';

abstract class ErrandState {}

class ErrandInitial extends ErrandState {}

class ErrandLoading extends ErrandState {}

class ErrandEmpty extends ErrandState {}

class ErrandLoaded extends ErrandState {
  final List<ErrandRequestModel> requests;

  ErrandLoaded(this.requests);
}

