import 'package:bloc/bloc.dart';
import '../data/models/loan_request_model.dart';
import 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanInitial());

  final List<LoanRequestModel> _requests = [];

  Future<void> loadRequests() async {
    emit(LoanLoading());

    await Future.delayed(const Duration(milliseconds: 300));

    if (_requests.isEmpty) {
      emit(LoanEmpty());
    } else {
      emit(LoanLoaded(List.from(_requests)));
    }
  }

  Future<void> addLoanRequest(
    DateTime date,
    double loan,
    String reason,
  ) async {
    final newRequest = LoanRequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: date,
      loan: loan,
      reason: reason,
      status: LoanStatus.pending,
    );

    _requests.insert(0, newRequest);

    emit(LoanLoaded(List.from(_requests)));
  }

  Future<void> deleteRequest(String id) async {
    _requests.removeWhere((request) => request.id == id);
    if (_requests.isEmpty) {
      emit(LoanEmpty());
    } else {
      emit(LoanLoaded(List.from(_requests)));
    }
  }

  Future<void> editRequest(
    String id,
    DateTime date,
    double loan,
    String reason,
  ) async {
    final request = _requests.firstWhere((request) => request.id == id);
    request.date = date;
    request.loan = loan;
    request.reason = reason;
    emit(LoanLoaded(List.from(_requests)));
  }
}
