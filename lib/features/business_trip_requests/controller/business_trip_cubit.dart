import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'business_trip_state.dart';

class BusinessTripCubit extends Cubit<BusinessTripState> {
  BusinessTripCubit() : super(BusinessTripInitial());
}
