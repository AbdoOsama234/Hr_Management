// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// import '../../../features/componnents/icon_button.dart';
// import '../../../features/features_owner/view/componnents/icon_button.dart';
// import '../../app_assets.dart';
// import '../../app_router.dart';
// import '../../constants.dart';
// import 'custom_loading_widget.dart';

// // class CustomCachedNetworkImage extends StatelessWidget {
// //   const CustomCachedNetworkImage({
// //     super.key, required this.imageUrl,
// //   });
// //   final String imageUrl;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       clipBehavior: Clip.hardEdge,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(Constants.defaultRadius),
// //       ),
// //       child: CachedNetworkImage(
// //
// //         imageUrl: imageUrl,
// //         placeholder: (context, url) => const CustomLoadingWidget(),
// //         errorWidget: (context, url, error) =>
// //             AppMainIconButton(
// //               isCirclar: true,
// //               icon: AppAssets.avatar3,
// //               fit: BoxFit.fill,
// //               iconSize: 40,
// //               onTap: () {
// //                 Navigator.pushNamed(context, Routes.profile);
// //               },
// //             ),
// //       ),
// //     );
// //   }
// // }
// class CustomCachedNetworkImage extends StatelessWidget {
//   const CustomCachedNetworkImage(
//       {super.key,
//       required this.imageUrl,
//       this.isCircular = false,
//       this.iconSize = 40,
//       this.padding = 5});
//   final double iconSize;
//   final String imageUrl;
//   final bool isCircular;
//   final double padding;
//   @override
//   Widget build(BuildContext context) {
//     Widget image = CachedNetworkImage(
//       imageUrl: imageUrl,
//       fit: BoxFit.cover,
//       placeholder: (context, url) => const CustomLoadingWidget(),
//       errorWidget: (context, url, error) => AppMainIconButton(
//         isCirclar: true,
//         icon: AppAssets.avatar3,
//         fit: BoxFit.cover,
//         padding: padding,
//         iconSize: iconSize,
//         onTap: () {
//           //Navigator.pushNamed(context, Routes.emplyeeDetailsprofile);
//         },
//       ),
//     );

//     // استخدم ClipOval للشكل الدائري بدون اعتماد على الحجم
//     return isCircular
//         ? ClipOval(child: image)
//         : ClipRRect(
//             borderRadius: BorderRadius.circular(Constants.defaultRadius),
//             child: image,
//           );
//   }
// }
