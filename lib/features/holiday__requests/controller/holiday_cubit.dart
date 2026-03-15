import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'holiday_state.dart';



class HolidayCubit extends Cubit<HolidayState> {
  HolidayCubit() : super(HolidayInitial());
}
