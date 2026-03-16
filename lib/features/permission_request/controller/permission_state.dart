import '../data/models/permission_request_model.dart';

abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

class PermissionLoading extends PermissionState {}

class PermissionEmpty extends PermissionState {}

class PermissionLoaded extends PermissionState {
  final List<PermissionRequestModel> requests;

  PermissionLoaded(this.requests);
}
