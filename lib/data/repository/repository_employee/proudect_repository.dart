// import 'package:dartz/dartz.dart';
// import 'package:electro_zone/app/network/error_handler.dart';
// import 'package:electro_zone/app/network/save_api.dart';
// import 'package:electro_zone/data/model/base_response.dart';
// import 'package:electro_zone/data/model/operating_system_response/operating_system_response.dart';
// import 'package:electro_zone/data/model/proudct/search_words_response.dart';
// import 'package:electro_zone/data/request/proudct/get_product_request.dart';
// import 'package:electro_zone/data/storage/local/app_prefs.dart';
// import 'package:injectable/injectable.dart';

// import '../model/cultures/cultures_response.dart';
// import '../model/favourite_response/get_favourite_response .dart';
// import '../model/menu_item/all_menu_item_response.dart';
// import '../model/phone_country/get_phone_country.dart';
// import '../model/proudct/get_proudcts_response.dart';
// import '../request/base_request.dart';
// import '../request/proudct/proudct_request.dart';
// import '../request/user/add_favourit_request.dart';
// import '../storage/remote/proudcts_api_service.dart';

// @injectable
// class ProudectsRepository {
//   final ProudectsService _proudectsService;
//   final SafeApi safeApi;
//   final AppPreferences appPreferences;

//   ProudectsRepository(
//     this._proudectsService,
//     this.safeApi,
//     this.appPreferences,
//   );

//   Future<Either<Failure, BaseResponse<List<CulturesResponse>>>>
//       getCultures() async {
//     return safeApi.call(apiCall: _proudectsService.getCultures());
//   }

//   Future<Either<Failure, BaseResponse<List<GetPhoneCountryResponse>>>>
//       getPhoneCountry() async {
//     return safeApi.call(apiCall: _proudectsService.getPhoneCountry());
//   }

//   Future<Either<Failure, BaseResponse<List<OperatingSystemResponse>>>>
//       getOperatingSystems() async {
//     return safeApi.call(apiCall: _proudectsService.getOperatingSystems());
//   }

//   Future<Either<Failure, BaseResponse<List<OperatingSystemResponse>>>>
//       getPieceType() async {
//     return safeApi.call(apiCall: _proudectsService.getPieceType());
//   }

//   Future<Either<Failure, BaseResponse<List<CategoryModel>>>>
//       getMenuItems() async {
//     return safeApi.call(apiCall: _proudectsService.getMenuItems());
//   }

//   Future<Either<Failure, BaseResponse<List<GetFavouriteResponse>>>>
//       getFavourite(String userId) async {
//     return safeApi.call(
//         apiCall: _proudectsService.getFavourite(userId: userId));
//   }

//   Future<Either<Failure, BaseResponse<bool>>> addToFavourite(
//       AddToFavouriteRequest addToFavouriteRequest) async {
//     return safeApi.call(
//         apiCall: _proudectsService.addToFavourite(
//             body: BaseRequest(addToFavouriteRequest)));
//   }

//   Future<Either<Failure, BaseResponse<ProudctModel>>> insertProudct(
//       AddProudctRequest addProudctRequest) async {
//     return await safeApi.call(
//         apiCall: _proudectsService.insertProudct(
//             body: BaseRequest(addProudctRequest)));
//   }

//   Future<Either<Failure, BaseResponse<GetproudcsResponse>>> getProudcts(
//       GetProductsRequest getproudcsRequst) async {
//     return safeApi.call(
//         apiCall:
//             _proudectsService.getProudcts(body: BaseRequest(getproudcsRequst)));
//   }

//   Future<Either<Failure, BaseResponse<List<AddProductImagesResponse>>>>
//       addProductImages(AddProductImagesRequst addProductImagesRequst) async {
//     return await safeApi.call(
//         apiCall: _proudectsService.addProductImages(
//             photo: addProductImagesRequst.filse,
//             productId: addProductImagesRequst.proudctId));
//   }

//   Future<Either<Failure, BaseResponse<ProudctModel>>> upDateProudct(
//       AddProudctRequest addProudctRequest, String id) async {
//     print(addProudctRequest.toJson());
//     return await safeApi.call(
//         apiCall: _proudectsService.upDateProudct(
//             body: BaseRequest(addProudctRequest), id: id));
//   }

//   Future<Either<Failure, BaseResponse<ProudctModel>>> getProduct(
//       String id) async {
//     return await safeApi.call(apiCall: _proudectsService.getProduct(id: id));
//   }

//   Future<Either<Failure, BaseResponse<ProudctModel>>> getProductWithLanguage(
//       String id) async {
//     return await safeApi.call(
//         apiCall: _proudectsService.getProductWithLanguage(id: id));
//   }

//   Future<Either<Failure, BaseResponse<bool>>> deleteProduct(String id) async {
//     return safeApi.call(apiCall: _proudectsService.deleteProduct(id: id));
//   }

//   Future<Either<Failure, BaseResponse<bool>>> deleteProductImage(
//       String id) async {
//     return safeApi.call(
//         apiCall: _proudectsService.deleteProductImage(imageId: id));
//   }

//   Future<Either<Failure, BaseResponse<bool>>> activateDeactivate(
//       String id) async {
//     return safeApi.call(apiCall: _proudectsService.activateDeactivate(id: id));
//   }

//   Future<Either<Failure, BaseResponse<List<SearchWordModel>>>>
//       getProductSuggestions(String query) async {
//     return await safeApi.call(
//       apiCall: _proudectsService.getProductSuggestions(
//         query: query,
//       ),
//     );
//   }

//   Future<Either<Failure, BaseResponse<List<SearchWordModel>>>>
//       getStoreSuggestions(String query) async {
//     return await safeApi.call(
//       apiCall: _proudectsService.getStoreSuggestions(
//         query: query,
//       ),
//     );
//   }
// }
