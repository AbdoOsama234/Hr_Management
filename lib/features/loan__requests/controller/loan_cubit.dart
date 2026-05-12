import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/features/loan__requests/data/models/loan_model.dart';
import 'package:hr_manegement/features/loan__requests/data/repository/loan_repository.dart';
import 'package:injectable/injectable.dart';
import '../data/models/loan_request.dart';
import '../data/models/loan_request_model.dart';
import 'loan_state.dart';
@injectable
class LoanCubit extends Cubit<LoanState> {

  final LoanRepository _loanRepository;
  LoanCubit(
      this._loanRepository
      ) : super(LoanInitial());

  static LoanCubit get(
      BuildContext context,
      )=>context.read<LoanCubit>();

  List<LoanModel>loans=[];
  int currentPage = 1;

  bool hasNext = true;

Future<void>getAllLoans({
  bool loadMore = false,
})async{
  if(state is GetAllLoansLoading||
     state is PaginationLoading||
      (loadMore && !hasNext)

  )
  {
    return;
  }
  if(loadMore){
    emit(PaginationLoading());
  }else{
    loans.clear();
    currentPage = 1;

    hasNext = true;

    emit(GetAllLoansLoading());
  }

  final result=
      await _loanRepository.getAllLoans(currentPage);

  result.fold(
    ///Error
      (failure){
        emit(GetAllLoansError(
          error: failure.message
        )
        );
      },
      ///Success
      (response){
        final data =response.result;

        loans.addAll(
            data?.loans??[],
        );

        hasNext =
            data?.pagination?.hasNext
                ?? false;

        if (hasNext) {
          currentPage++;
        }

        if (loans.isEmpty) {

          emit(LoansEmpty());

        } else {

          emit(GetAllLoansLoaded());
        }

        debugPrint(
          "errands.length = ${loans.length}",
        );
      },
   );
}

  /// =========================
  /// ➕ CREATE ERRAND
  /// =========================
  Future<void> createLoans({
    required LoanRequest model,
  }) async {

    emit(CreateLoanLoading());

    final result =
    await _loanRepository
        .createLoans(model);

    result.fold(

      /// ❌ FAILURE
          (failure) {

        emit(
          CreateLoanError(
            error: failure.message,
          ),
        );
      },

      /// ✅ SUCCESS
          (response) async {

        emit(CreateLoanSuccess());

        await getAllLoans();
      },
    );
  }

  /// =========================
  /// ✏ UPDATE ERRAND
  /// =========================
  Future<void> updateLoans({
    required int id,
    required LoanRequest model,
  }) async {

    emit(UpdateLoanLoading(id: id,),
    );

    final result = await _loanRepository.updateLoans(id, model,);

    result.fold(

      /// ❌ FAILURE
          (failure) {

        emit(
          UpdateLoanError(
            error: failure.message,
          ),
        );
      },

      /// ✅ SUCCESS
          (response) async {

        emit(UpdateLoanSuccess());

        await getAllLoans();
      },
    );
  }

  /// =========================
  /// 🗑 DELETE ERRAND
  /// =========================
  Future<void> deleteLoans(
      int id,
      ) async {

    emit(
      DeleteLoanLoading(
        id: id,
      ),
    );

    final result =
    await _loanRepository
        .deleteLoans(id);

    result.fold(

      /// ❌ FAILURE
          (failure) {

        emit(
          DeleteLoanError(
            error: failure.message,
          ),
        );
      },

      /// ✅ SUCCESS
          (response) async {

        emit(DeleteLoanSuccess());

        await getAllLoans();
      },
    );
  }
}

















