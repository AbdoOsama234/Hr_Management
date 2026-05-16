// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../ sheard/componnents/code_picker_textfield.dart';
// import '../../../../ sheard/componnents/custom_app_bar.dart';
// import '../../../../ sheard/componnents/custom_button.dart';
// import '../../../../core/app_sized_box.dart';
//
// import '../widgets/auth_header.dart';
// import '../widgets/title_row.dart';
// import 'otp_verification_screen.dart';
//
// class ForgetPasswordScreen extends StatefulWidget {
//   const ForgetPasswordScreen({super.key});
//
//   @override
//   State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
// }
//
// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   final TextEditingController _phoneController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Forget Password'.tr()),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               AuthHeader(
//                 subtitle: 'Enter your phone number to reset your password'.tr(),
//               ),
//
//               TitleRow(title: 'Phone'.tr(), icon: Icons.phone),
//               AppSizedBox.h1,
//               CodePickerTextFieldTwo(
//                 controller: _phoneController,
//                 labelText: 'Phone...'.tr(),
//               ),
//
//               AppSizedBox.h6,
//
//               CustomButton(
//                 text: 'Send OTP'.tr(),
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     // TODO: Implement send OTP logic with Cubit
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const OtpVerificationScreen(),
//                       ),
//                     );
//                   }
//                 },
//               ),
//
//               AppSizedBox.h3,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
