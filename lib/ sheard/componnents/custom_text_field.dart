import 'package:flutter/material.dart';
import 'package:hr_manegement/core/constants.dart';
import 'package:intl/intl.dart' as intl;
import 'package:hr_manegement/core/extensions.dart';
import 'dart:ui' as ui;

import '../../../../core/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final int? max;
  final int? min;
  final double? width;
  final String? Function(String?)? validator;
  final String? hint;
  final bool? enable;
  final bool align;
  final TextEditingController controller;
  final Widget? prefix;
  final Widget? suffixIcon;
  final TextInputType? type;
  final VoidCallback? onTapPassword;
  final void Function(String)? onChange;
  final void Function(String)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final double radius;
  final double? verticalContentPadding;
  final double? horizontalContentPadding;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool readOnly;
  final TextInputAction? action;
  final bool isPhone;
  final String? initialValue;
  final int? maxLength;
  const CustomTextField({
    required this.controller,
    this.onSaved,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.action,
    this.enable = true,
    this.align = true,
    required this.hint,
    this.verticalContentPadding,
    this.horizontalContentPadding,
    this.max = 1,
    this.min,
    this.onChange,
    this.type,
    this.validator,
    this.onTapPassword,
    super.key,
    this.prefix,
    this.onTap,
    this.radius = Constants.defaultRadius,
    this.width,
    this.suffixIcon,
    this.focusNode,
    this.isPhone = false,
    this.maxLength,
    this.initialValue,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text);
  }

  final ValueNotifier<TextDirection> _textDir = ValueNotifier(
    ui.TextDirection.ltr,
  );
  late bool showPassword;
  @override
  void initState() {
    super.initState();
    bool isR = isRTL(widget.controller.text);
    if (isR) {
      _textDir.value = TextDirection.rtl;
    } else {
      _textDir.value = TextDirection.ltr;
    }

    showPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(widget.radius.sp),
      ),
      width: widget.width,
      //height: 6.5.h,
      child: ValueListenableBuilder<TextDirection>(
        valueListenable: _textDir,
        builder: (context, value, child) {
          if (widget.controller.text.trim().length < 100) {
            final dir = getDirection(widget.controller.text);
            if (dir != value) _textDir.value = dir;
          }
          return TextFormField(
            initialValue: widget.initialValue,
            onTap: () {
              widget.onTap != null ? widget.onTap!() : null;
              if (widget.controller.selection ==
                  TextSelection.fromPosition(
                    TextPosition(offset: widget.controller.text.length - 1),
                  )) {
                setState(() {
                  widget.controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.controller.text.length),
                  );
                });
              }
            },
            maxLength: widget.maxLength,
            readOnly: widget.readOnly,
            textDirection: widget.align ? _textDir.value : TextDirection.rtl,
            onSaved: (widget.onSaved != null)
                ? (newValue) {
              if (newValue!.trim().length < 100) {
                final dir = getDirection(newValue);
                if (dir != value) _textDir.value = dir;
              }
              return widget.onSaved!(newValue);
            }
                : null,
            onChanged: (input) {
              if (input.trim().length < 100) {
                final dir = getDirection(input);
                if (dir != value) _textDir.value = dir;
              }
              bool isR = isRTL(input);
              if (isR) {
                _textDir.value = TextDirection.rtl;
              } else {
                _textDir.value = TextDirection.ltr;
              }
              if (widget.onChange != null) {
                widget.onChange!(input);
              }
            },
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: widget.enable,
            focusNode: widget.focusNode,
            onFieldSubmitted: (value) {
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(value);
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            textInputAction: widget.action,
            maxLines: widget.max,
            minLines: widget.min,
            obscuringCharacter: '*',
            controller: widget.controller,

            // cursorColor: AppColors.primary,
            // style: AppTextStyle.getBoldStyle(
            //   color: AppColors.whiteColor,
            //   fontSize: 12.sp,
            // ),
            keyboardType: widget.type,
            textAlignVertical: TextAlignVertical.center,
            obscureText: widget.type == TextInputType.visiblePassword
                ? showPassword
                : false,
            validator: widget.validator,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.verticalContentPadding ?? 1.2.h,
                horizontal: widget.horizontalContentPadding ?? 3.w,
              ),
              alignLabelWithHint: true,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 25,
                minHeight: 25,
                maxHeight: 55,
                maxWidth: 55,
              ),
              prefixIconConstraints: (!widget.isPhone)
                  ? const BoxConstraints(
                // minWidth: 25,
                // minHeight: 25,
                maxHeight: 55,
                maxWidth: 100,
              )
                  : null,
              suffixIcon: widget.type == TextInputType.visiblePassword
                  ? Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 2.w,
                    ),
                    child: Icon(
                      showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
                  : widget.suffixIcon != null
                  ? Padding(
                padding: EdgeInsetsDirectional.only(start: 3.w, end: 5.w),
                child: widget.suffixIcon,
              )
                  : null,
              prefixIcon: widget.prefix != null
                  ? GestureDetector(
                onTap: widget.onTapPassword,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 5.w,
                    end: 3.w,
                  ),
                  child: widget.prefix,
                ),
              )
                  : null,
              hintText: widget.hint!,
              labelText: widget.hint!,
              labelStyle: TextStyle(
                fontSize: 16,
                color: AppColors.textSub.withValues(alpha: 0.5),
              ),
              hintStyle: TextStyle(
                fontSize: 16,
                color: AppColors.textSub.withValues(alpha: 0.5),
              ),
              enabledBorder: enabledBorder(radius: widget.radius.sp),
              border: border(radius: widget.radius.sp),
              disabledBorder: disabledBorder(radius: widget.radius.sp),
              focusedBorder: focusedBorder(radius: widget.radius.sp),
              focusedErrorBorder: errorBorder(radius: widget.radius.sp),
              errorBorder: errorBorder(radius: widget.radius.sp),
            ),
          );
        },
      ),
    );
  }

  TextDirection getDirection(String v) {
    final string = v.trim();
    if (string.isEmpty) return TextDirection.ltr;
    final firstUnit = string.codeUnitAt(0);
    if (firstUnit > 0x0600 && firstUnit < 0x06FF ||
        firstUnit > 0x0750 && firstUnit < 0x077F ||
        firstUnit > 0x07C0 && firstUnit < 0x07EA ||
        firstUnit > 0x0840 && firstUnit < 0x085B ||
        firstUnit > 0x08A0 && firstUnit < 0x08B4 ||
        firstUnit > 0x08E3 && firstUnit < 0x08FF ||
        firstUnit > 0xFB50 && firstUnit < 0xFBB1 ||
        firstUnit > 0xFBD3 && firstUnit < 0xFD3D ||
        firstUnit > 0xFD50 && firstUnit < 0xFD8F ||
        firstUnit > 0xFD92 && firstUnit < 0xFDC7 ||
        firstUnit > 0xFDF0 && firstUnit < 0xFDFC ||
        firstUnit > 0xFE70 && firstUnit < 0xFE74 ||
        firstUnit > 0xFE76 && firstUnit < 0xFEFC ||
        firstUnit > 0x10800 && firstUnit < 0x10805 ||
        firstUnit > 0x1B000 && firstUnit < 0x1B0FF ||
        firstUnit > 0x1D165 && firstUnit < 0x1D169 ||
        firstUnit > 0x1D16D && firstUnit < 0x1D172 ||
        firstUnit > 0x1D17B && firstUnit < 0x1D182 ||
        firstUnit > 0x1D185 && firstUnit < 0x1D18B ||
        firstUnit > 0x1D1AA && firstUnit < 0x1D1AD ||
        firstUnit > 0x1D242 && firstUnit < 0x1D244) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }
}

OutlineInputBorder errorBorder({double? radius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius ?? 10),
    borderSide: const BorderSide(color: AppColors.red, width: 1.5),
  );
}

OutlineInputBorder disabledBorder({double? radius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius ?? 10),
    borderSide: BorderSide(color: AppColors.iconBgColor, width: 1),
  );
}

OutlineInputBorder focusedBorder({double? radius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius ?? 10),
    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
  );
}

OutlineInputBorder border({double? radius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius ?? 10),
    borderSide: BorderSide(color: AppColors.iconBgColor, width: 1),
  );
}

OutlineInputBorder enabledBorder({double? radius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius ?? 10),
    borderSide: BorderSide(color: AppColors.iconBgColor, width: 1),
  );
}
