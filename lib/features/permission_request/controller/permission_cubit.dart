import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../data/models/permission_model.dart';
import '../data/models/permission_request.dart';
import '../data/repository/permission_repository.dart';
import 'permission_state.dart';

@injectable
class PermissionCubit extends Cubit<PermissionState> {
  final PermissionRepository _repository;

  static PermissionCubit get(BuildContext context) =>
      context.read<PermissionCubit>();

  PermissionCubit(this._repository) : super(PermissionInitial());

  /// 📥 DATA
  List<PermissionModel> permissions = [];
  int _currentPage = 1;
  bool _hasNext = true;

  Future<void> getAllPermissions({bool loadMore = false}) async {
    if (state is GetAllPermissionsLoading ||
        state is PaginationLoading ||
        (loadMore && !_hasNext)) {
      return;
    }

    if (loadMore) {
      emit(PaginationLoading());
    } else {
      permissions.clear();
      _currentPage = 1;
      _hasNext = true;
      emit(GetAllPermissionsLoading());
    }

    final result = await _repository.getAllPermissions(_currentPage);
    result.fold(
      (l) {
        emit(GetAllPermissionsError(error: l.message));
      },
      (r) {
        permissions.addAll(r.result?.permissions ?? []);
        _hasNext = r.result?.pagination?.hasNext ?? false;
        if (_hasNext) {
          _currentPage++;
        }
        emit(GetAllPermissionsLoaded());
      },
    );
  }

  /// ➕ CREATE
  Future<void> createPermission({required PermissionRequest model}) async {
    emit(CreatePermissionLoading());

    final result = await _repository.createPermission(model);

    result.fold(
      (failure) {
        emit(CreatePermissionError(error: failure.message));
      },
      (response) async {
        emit(CreatePermissionSuccess());
        await getAllPermissions(); // Refresh list
      },
    );
  }

  /// 🗑 DELETE
  Future<void> deletePermission(int id) async {
    emit(DeletePermissionLoading(id: id));

    final result = await _repository.deletePermission(id);

    result.fold(
      (failure) {
        emit(DeletePermissionError(error: failure.message));
      },
      (response) async {
        emit(DeletePermissionSuccess());
        await getAllPermissions(); // Refresh list
      },
    );
  }

  /// 🔄 UPDATE
  Future<void> updatePermission({
    required int id,
    required PermissionRequest model,
  }) async {
    emit(UpdatePermissionLoading(id: id));

    final result = await _repository.updatePermission(id, model);

    result.fold(
      (failure) {
        emit(UpdatePermissionError(error: failure.message));
      },
      (response) async {
        emit(UpdatePermissionSuccess());
        await getAllPermissions(); // Refresh list
      },
    );
  }
}
