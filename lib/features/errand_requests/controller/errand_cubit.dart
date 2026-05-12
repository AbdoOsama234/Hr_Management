import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../data/models/errand_model.dart';
import '../data/models/errand_request.dart';
import '../data/repository/errand_repository.dart';

import 'errand_state.dart';

@injectable
class ErrandCubit extends Cubit<ErrandState> {

  final ErrandRepository _errandRepository;

  ErrandCubit(
      this._errandRepository,
      ) : super(ErrandInitial());

  static ErrandCubit get(
      BuildContext context,
      ) => context.read<ErrandCubit>();

  /// =========================
  /// 📥 DATA
  /// =========================
  List<ErrandModel> errands = [];

  int currentPage = 1;

  bool hasNext = true;

  /// =========================
  /// 📥 GET ALL ERRANDS
  /// =========================
  Future<void> getAllErrands({
    bool loadMore = false,
  }) async {

    if (
    state is GetAllErrandsLoading ||
        state is PaginationLoading ||
        (loadMore && !hasNext)
    ) {
      return;
    }

    if (loadMore) {

      emit(PaginationLoading());

    } else {

      errands.clear();

      currentPage = 1;

      hasNext = true;

      emit(GetAllErrandsLoading());
    }

    final result =
    await _errandRepository
        .getAllErrands(currentPage);

    result.fold(

      /// ❌ FAILURE
          (failure) {

        emit(
          GetAllErrandsError(
            error: failure.message,
          ),
        );
      },

      /// ✅ SUCCESS
          (response) {

        final data = response.result;

        errands.addAll(
          data?.missions ?? [],
        );

        hasNext =
            data?.pagination?.hasNext
                ?? false;

        if (hasNext) {
          currentPage++;
        }

        if (errands.isEmpty) {

          emit(ErrandEmpty());

        } else {

          emit(GetAllErrandsLoaded());
        }

        debugPrint(
          "errands.length = ${errands.length}",
        );
      },
    );
  }

  /// =========================
  /// ➕ CREATE ERRAND
  /// =========================
  Future<void> createErrands({
    required ErrandRequest model,
  }) async {

    emit(CreateErrandLoading());

    final result =
    await _errandRepository
        .createErrands(model);

    result.fold(

      /// ❌ FAILURE
          (failure) {

        emit(
          CreateErrandError(
            error: failure.message,
          ),
        );
      },

      /// ✅ SUCCESS
          (response) async {

        emit(CreateErrandSuccess());

        await getAllErrands();
      },
    );
  }

  /// =========================
  /// ✏ UPDATE ERRAND
  /// =========================
  Future<void> updateErrands({
    required int id,
    required ErrandRequest model,
  }) async {

    emit(UpdateErrandLoading(id: id,),
    );

    final result = await _errandRepository.updateErrands(id, model,);

    result.fold(

      /// ❌ FAILURE
          (failure) {

        emit(
          UpdateErrandError(
            error: failure.message,
          ),
        );
      },

      /// ✅ SUCCESS
          (response) async {

        emit(UpdateErrandSuccess());

        await getAllErrands();
      },
    );
  }

  /// =========================
  /// 🗑 DELETE ERRAND
  /// =========================
  Future<void> deleteErrands(
      int id,
      ) async {

    emit(
      DeleteErrandLoading(
        id: id,
      ),
    );

    final result =
    await _errandRepository
        .deleteErrands(id);

    result.fold(

      /// ❌ FAILURE
          (failure) {

        emit(
          DeleteErrandError(
            error: failure.message,
          ),
        );
      },

      /// ✅ SUCCESS
          (response) async {

        emit(DeleteErrandSuccess());

        await getAllErrands();
      },
    );
  }
}