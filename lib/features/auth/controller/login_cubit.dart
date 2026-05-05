import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/di/di.dart';
import '../../../data/storage/local/app_prefs.dart';
import '../data/repository/auth_repository.dart';
import '../data/model/user_model.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _repository;

  LoginCubit(this._repository) : super(LoginInitial());

  static LoginCubit get(BuildContext context) => context.read<LoginCubit>();

  /// 🔐 Login
  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    _repository.login(email, password).then((value) {
      value.fold(
        (l) {
          emit(LoginError(error: l.message));
          debugPrint("Login error: ${l.message}");
        },
        (r) async {
          if (r.result != null) {
            await getIt<AppPreferences>().login(r.result!);
            emit(LoginSuccess(data: r.result!));
          } else {
            emit(LoginError(error: r.message ?? "Login failed"));
          }
        },
      );
    });
  }
}
