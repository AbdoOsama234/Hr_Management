// import 'dart:io';

// import 'package:hr_manegement/core/network/error_handler.dart';
// import 'package:dartz/dartz.dart';

// import '../../models/models_owner/FlatTypeModel.dart';
// import '../../models/models_owner/flat_model_request.dart';
// import '../../models/models_owner/my_aqar_flat_model.dart';
// import '../../models/models_owner/spec_by_type_model.dart';

// abstract class FloorsRepo{
//   Future<Either<FailureException,List<AqarFlatInfo>>> getAqarFlat({required String aqarID});

//   Future<Either<FailureException,List<FlatTypeInfo>>> getFlatType({required String ownerID});

//   Future<Either<FailureException,List<SpecByTypeInfo>>> getSpecByType({required String flatTypesID});

//   Future<Either<FailureException, bool>> addFlat({required FlatModelRequest flatModelRequest, File? fileImage,required String token});
// }
