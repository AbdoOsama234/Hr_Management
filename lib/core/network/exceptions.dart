class CustomException{
  final String errorMessage;
  CustomException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}
class UnknownException extends CustomException{
  UnknownException({required super.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}