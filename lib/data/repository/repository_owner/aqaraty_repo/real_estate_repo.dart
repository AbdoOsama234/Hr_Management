// import 'dart:io';

// import 'package:dartz/dartz.dart';

// import '../../../core/network/error_handler.dart';
// import '../../models/models_owner/aqar_model.dart';
// import '../../models/models_owner/my_areas_model.dart';
// import '../../models/models_owner/my_gover_model.dart';

// abstract class RealEstateRepo{

//   Future<Either<FailureException, List<AreaData>>> getMyAreas();

//   Future<Either<FailureException, List<GoverDataModel>>> getMyGover({required String areaID});

//   Future<Either<FailureException, AqarInfo>> addAqar({required AqarInfo aqarInfo, File? fileImage ,required String token});

//   Future<Either<FailureException,List<AqarInfo>>>getAqars({required String ownerID});

//   Future<Either<FailureException, bool>> deleteAqar({required String aqarID,required String token});

//   Future<Either<FailureException, bool>> editAqar({required AqarInfo aqarInfo, File? fileImage ,required String token});

// }