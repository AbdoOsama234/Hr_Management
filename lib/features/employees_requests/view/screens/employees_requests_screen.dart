// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:hr_manegement/core/app_colors.dart';
// import 'package:hr_manegement/core/app_sized_box.dart';
// import 'package:hr_manegement/core/app_assets.dart';
// import 'package:hr_manegement/core/extensions.dart';
// import 'package:hr_manegement/core/text_style.dart';

// import '../../../../ sheard/componnents/custom_app_bar.dart';
// import '../../../../ sheard/componnents/empty_screen.dart';
// import '../../../../ sheard/componnents/loading_widget.dart';
// import '../../../../ sheard/componnents/search_bar.dart';
// import '../../../../ sheard/componnents/show_bottom_sheet.dart';

// import '../../data/models/employees_requests_model.dart';
// import '../../controller/employees_requests_cubit.dart';
// import '../../controller/employees_requests_state.dart';
// import '../widgets/employees_requests_item_card.dart';

// class EmployeesRequestsScreen extends StatefulWidget {
//   const EmployeesRequestsScreen({super.key});

//   @override
//   State<EmployeesRequestsScreen> createState() => _EmployeesRequestsScreenState();
// }

// class _EmployeesRequestsScreenState extends State<EmployeesRequestsScreen> {
//   var searchController = TextEditingController();
//   Timer? _debounce;
//   RequestStatus? _selectedStatusFilter;
//   RequestType? _selectedTypeFilter;

//   String _getStatusLabel(RequestStatus status) {
//     switch (status) {
//       case RequestStatus.pindding:
//         return 'status_pending'.tr();
//       case RequestStatus.accepted:
//         return 'status_accepted'.tr();
//       case RequestStatus.refused:
//         return 'status_refused'.tr();
//     }
//   }

//   String _getTypeLabel(RequestType type) {
//     switch (type) {
//       case RequestType.holiday:
//         return 'type_holiday'.tr();
//       case RequestType.permission:
//         return 'type_permission'.tr();
//       case RequestType.loan:
//         return 'type_loan'.tr();
//       case RequestType.businessTrip:
//         return 'type_business_trip'.tr();
//       case RequestType.errand:
//         return 'type_errand'.tr();
//       case RequestType.idea:
//         return 'type_idea'.tr();
//     }
//   }

//   void _showFilterBottomSheet() {
//     showAppBottomSheet(
//       context: context,
//       title: 'filter_requests'.tr(),
//       body: StatefulBuilder(
//         builder: (context, setBottomSheetState) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'filter_by_status'.tr(),
//                 style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
//               ),
//               AppSizedBox.h1,
//               Wrap(
//                 spacing: 2.w,
//                 runSpacing: 1.h,
//                 children: RequestStatus.values.map((status) {
//                   final isSelected = _selectedStatusFilter == status;
//                   return ChoiceChip(
//                     label: Text(_getStatusLabel(status)),
//                     selected: isSelected,
//                     selectedColor: AppColors.primary.withOpacity(0.2),
//                     onSelected: (selected) {
//                       setBottomSheetState(() {
//                         _selectedStatusFilter = selected ? status : null;
//                       });
//                       setState(() {});
//                     },
//                   );
//                 }).toList(),
//               ),
//               AppSizedBox.h3,
//               Text(
//                 'filter_by_type'.tr(),
//                 style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
//               ),
//               AppSizedBox.h1,
//               Wrap(
//                 spacing: 2.w,
//                 runSpacing: 1.h,
//                 children: RequestType.values.map((type) {
//                   final isSelected = _selectedTypeFilter == type;
//                   return ChoiceChip(
//                     label: Text(_getTypeLabel(type)),
//                     selected: isSelected,
//                     selectedColor: AppColors.primary.withOpacity(0.2),
//                     onSelected: (selected) {
//                       setBottomSheetState(() {
//                         _selectedTypeFilter = selected ? type : null;
//                       });
//                       setState(() {});
//                     },
//                   );
//                 }).toList(),
//               ),
//               AppSizedBox.h2,
//             ],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => EmployeesRequestsCubit()..loadRequests(),
//       child: Scaffold(
//         appBar: CustomAppBar(title: 'employees_requests'.tr()),
//         body: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               AppSearchBar(
//                 controller: searchController,
//                 onChange: (value) {
//                   if (_debounce?.isActive ?? false) {
//                     _debounce!.cancel();
//                   }
//                   _debounce = Timer(const Duration(milliseconds: 500), () {
//                     // Search Logic
//                   });
//                 },
//                 onTapIconButton: _showFilterBottomSheet,
//               ),
//               AppSizedBox.h2,
//               Expanded(
//                 child: BlocBuilder<EmployeesRequestsCubit, EmployeesRequestsState>(
//                   builder: (context, state) {
//                     if (state is EmployeesRequestsLoading) {
//                       return const Center(child: LoaderWidget());
//                     }

//                     if (state is EmployeesRequestsEmpty) {
//                       return EmptyScreen(
//                         title: 'no_requests'.tr(),
//                         description: 'no_requests_subtitle'.tr(),
//                         image: AppAssets.appLogo,
//                       );
//                     }

//                     if (state is EmployeesRequestsLoaded) {
//                       List<EmployeesRequestsModel> filteredRequests = state.requests;

//                       if (_selectedStatusFilter != null) {
//                         filteredRequests = filteredRequests
//                             .where((r) => r.status == _selectedStatusFilter)
//                             .toList();
//                       }

//                       if (_selectedTypeFilter != null) {
//                         filteredRequests = filteredRequests
//                             .where((r) => r.type == _selectedTypeFilter)
//                             .toList();
//                       }

//                       if (filteredRequests.isEmpty) {
//                         return EmptyScreen(
//                           title: 'no_requests'.tr(),
//                           description: 'no_requests_subtitle'.tr(),
//                           image: AppAssets.appLogo,
//                         );
//                       }

//                       return RefreshIndicator(
//                         onRefresh: () =>
//                             context.read<EmployeesRequestsCubit>().loadRequests(),
//                         child: ListView.builder(
//                           itemCount: filteredRequests.length,
//                           itemBuilder: (context, index) {
//                             return TweenAnimationBuilder<double>(
//                               duration: Duration(
//                                 milliseconds: 300 + (index * 100),
//                               ),
//                               tween: Tween(begin: 0.0, end: 1.0),
//                               curve: Curves.easeIn,
//                               builder: (context, value, child) {
//                                 return Opacity(
//                                   opacity: value,
//                                   child: Transform.translate(
//                                     offset: Offset(0, 20 * (1 - value)),
//                                     child: child,
//                                   ),
//                                 );
//                               },
//                               child: EmployeesRequestsItemCard(
//                                 request: filteredRequests[index],
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     }

//                     return const SizedBox();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
