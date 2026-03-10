import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'holiday_state.dart';

class HolidayCubit extends Cubit<HolidayState> {
  HolidayCubit() : super(HolidayInitial());
}
