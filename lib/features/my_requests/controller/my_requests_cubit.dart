import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../data/models/my_request_model.dart';
import 'my_requests_state.dart';
import '../../ideas/data/models/idea_model.dart';
import '../../business_trip_requests/data/models/business_trip_request_model.dart';
import '../../errand_requests/data/models/errand_request_model.dart';
import '../../holiday__requests/data/models/holiday_request_model.dart';
import '../../loan__requests/data/models/loan_request_model.dart';
import '../../permission_request/data/models/permission_request_model.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  MyRequestsCubit() : super(MyRequestsInitial());

  final List<MyRequestModel> _requests = [];

  Future<void> loadRequests() async {
    emit(MyRequestsLoading());

    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 400));

    if (_requests.isEmpty) {
      _requests.addAll([
        MyRequestModel(
          id: '1',
          date: DateTime.now().subtract(const Duration(days: 1)),
          changeStateNotes: '',
          type: RequestType.holiday,
          status: RequestStatus.pindding,
          holidayRequestModel: HolidayRequestModel(
            id: 'h1',
            startDate: DateTime.now().add(const Duration(days: 5)),
            endDate: DateTime.now().add(const Duration(days: 10)),
            reason: 'Annual family vacation'.tr(),
            status: HolidayStatus.pending,
          ),
        ),
        MyRequestModel(
          id: '2',
          date: DateTime.now().subtract(const Duration(days: 2)),
          changeStateNotes: 'Looks good.'.tr(),
          type: RequestType.businessTrip,
          status: RequestStatus.accepted,
          businessTripRequestModel: BusinessTripRequestModel(
            id: 'b1',
            startDate: DateTime.now().add(const Duration(days: 2)),
            endDate: DateTime.now().add(const Duration(days: 4)),
            days: 2,
            reason: 'Client meeting in Dubai'.tr(),
            status: BusinessTripStatus.approved,
          ),
        ),
        MyRequestModel(
          id: '3',
          date: DateTime.now().subtract(const Duration(days: 3)),
          changeStateNotes: 'Not feasible right now.'.tr(),
          type: RequestType.idea,
          status: RequestStatus.refused,
          idea: IdeaModel(
            id: 'i1',
            date: DateTime.now().subtract(const Duration(days: 3)),
            ideaExplain: 'Implement a new AI feature for better search results.'
                .tr(),
            ideaLink: 'https://example.com/ai-search',
            type: IdeaType.programming,
            status: IdeaStatus.rejected,
          ),
        ),
        MyRequestModel(
          id: '4',
          date: DateTime.now(),
          changeStateNotes: '',
          type: RequestType.errand,
          status: RequestStatus.pindding,
          errandRequestModel: ErrandRequestModel(
            id: 'e1',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(hours: 4)),
            days: 1, // Or hours
            reason: 'Going to the bank'.tr(),
            status: ErrandStatus.pending,
          ),
        ),
        MyRequestModel(
          id: '5',
          date: DateTime.now().subtract(const Duration(days: 5)),
          changeStateNotes: 'Insufficient funds.'.tr(),
          type: RequestType.loan,
          status: RequestStatus.refused,
          loanRequestModel: LoanRequestModel(
            id: 'l1',
            date: DateTime.now(),
            loan: 5000.0,
            reason: 'Car maintenance'.tr(),
            status: LoanStatus.rejected,
          ),
        ),
        MyRequestModel(
          id: '6',
          date: DateTime.now().subtract(const Duration(hours: 5)),
          changeStateNotes: '',
          type: RequestType.permission,
          status: RequestStatus.pindding,
          permissionRequestModel: PermissionRequestModel(
            id: 'p1',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(hours: 3)),
            hours: 3.0,
            reason: 'Doctor appointment'.tr(),
            status: PermissionStatus.pending,
          ),
        ),
      ]);
    }

    if (_requests.isEmpty) {
      emit(MyRequestsEmpty());
    } else {
      emit(MyRequestsLoaded(List.from(_requests)));
    }
  }

  void updateRequestState({
    required String requestId,
    required RequestStatus newStatus,
    required String changeStateNotes,
  }) {
    final index = _requests.indexWhere((r) => r.id == requestId);
    if (index != -1) {
      _requests[index].status = newStatus;
      _requests[index].changeStateNotes = changeStateNotes;

      if (state is MyRequestsLoaded) {
        emit(MyRequestsLoaded(List.from(_requests)));
      }
    }
  }
}
