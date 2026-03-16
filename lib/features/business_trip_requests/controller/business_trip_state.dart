import '../data/models/business_trip_request_model.dart';

abstract class BusinessTripState {}

class BusinessTripInitial extends BusinessTripState {}

class BusinessTripLoading extends BusinessTripState {}

class BusinessTripEmpty extends BusinessTripState {}

class BusinessTripLoaded extends BusinessTripState {
  final List<BusinessTripRequestModel> requests;

  BusinessTripLoaded(this.requests);
}
