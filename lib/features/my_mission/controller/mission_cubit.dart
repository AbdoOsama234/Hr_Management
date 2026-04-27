import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../data/models/mission_model.dart';
import 'mission_state.dart';

class MyMissionCubit extends Cubit<MyMissionState> {
  MyMissionCubit() : super(MyMissionInitial());

  final List<MyMissionModel> _missions = [];

  Future<void> loadMissions() async {
    emit(MyMissionLoading());

    // Simulating network delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (_missions.isEmpty) {
      _missions.addAll([
        MyMissionModel(
          id: '1',
          date: DateTime.now(),
          status: MissionStatus.newTask,
          importance: MissionImportance.high,
          notes: 'مراجعة تصميم واجهة المستخدم لشاشة المهام'.tr(),
        ),
        MyMissionModel(
          id: '2',
          date: DateTime.now(),
          status: MissionStatus.progressing,
          importance: MissionImportance.medium,
          notes: 'تنفيذ API لعرض قائمة المهام وربطها بالـ UI'.tr(),
        ),
        MyMissionModel(
          id: '3',
          date: DateTime.now().add(const Duration(days: 1)),
          status: MissionStatus.reviewing,
          importance: MissionImportance.low,
          notes: 'اختبار الأداء وإصلاح الأخطاء في شاشة المهام'.tr(),
        ),
        MyMissionModel(
          id: '4',
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: MissionStatus.completed,
          importance: MissionImportance.high,
          notes: 'إضافة خاصية الإشعارات للتذكير بالمهام'.tr(),
        ),
      ]);    }

    if (_missions.isEmpty) {
      emit(MyMissionEmpty());
    } else {
      emit(MyMissionLoaded(List.from(_missions)));
    }
  }
}