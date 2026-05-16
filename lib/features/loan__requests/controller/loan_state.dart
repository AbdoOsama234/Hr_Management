abstract class LoanState {}

class LoanInitial extends LoanState {}

class GetAllLoansLoading extends LoanState {}

class GetAllLoansLoaded extends LoanState {}

class GetAllLoansError extends LoanState {
  final String? error;

  GetAllLoansError({this.error});
}

class LoansEmpty extends LoanState {}

class PaginationLoading extends LoanState {}

///Create
class CreateLoanLoading extends LoanState {}

class CreateLoanSuccess extends LoanState {}

class CreateLoanError extends LoanState {
  final String? error;
  CreateLoanError({this.error});
}

///Update

class UpdateLoanLoading extends LoanState {
  final int id;
  UpdateLoanLoading({required this.id});
}

class UpdateLoanSuccess extends LoanState {}

class UpdateLoanError extends LoanState {
  final String? error;
  UpdateLoanError({this.error});
}

///Delete

class DeleteLoanLoading extends LoanState {
  final int id;
  DeleteLoanLoading({required this.id});
}

class DeleteLoanSuccess extends LoanState {}

class DeleteLoanError extends LoanState {
  final String? error;
  DeleteLoanError({this.error});
}
