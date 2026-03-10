import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanInitial());
}
