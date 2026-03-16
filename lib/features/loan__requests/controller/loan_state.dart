import '../data/models/loan_request_model.dart';

abstract class LoanState {}

class LoanInitial extends LoanState {}

class LoanLoading extends LoanState {}

class LoanEmpty extends LoanState {}

class LoanLoaded extends LoanState {
  final List<LoanRequestModel> requests;

  LoanLoaded(this.requests);
}
