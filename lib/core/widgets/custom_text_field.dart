import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_app/core/resources/assets_manager.dart';
import 'package:learning_app/core/resources/color_manager.dart';
import 'package:learning_app/core/resources/font_manager.dart';
import 'package:learning_app/core/resources/styles_manager.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.label,
    this.hint,
    this.isObscured = false,
    this.iconData,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor,
    this.readOnly = false,
    this.validation,
    this.onTap,
    this.maxLines,
    this.prefixIcon,
    this.borderBackgroundColor,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String? hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderBackgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;
  final void Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
                padding:  EdgeInsets.only(top: 2.h),
                child: Text(
                  widget.label!,
                  style:
                      widget.labelTextStyle ??
                      getMediumStyle(
                        color: ColorManager.white,
                      ).copyWith(fontSize: FontSize.s18),
                ),
              )
            : const SizedBox(),
        Container(
          margin: EdgeInsets.only(top: 5.h),
          decoration: BoxDecoration(
            color:
                widget.backgroundColor ??
                ColorManager.primaryDark.withOpacity(.15),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: widget.borderBackgroundColor ?? ColorManager.transparent,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            style: getMediumStyle(
              color: ColorManager.black,
            ).copyWith(fontSize: FontSize.s18),
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: widget.cursorColor ?? ColorManager.black,
            onTap: widget.onTap,
            onEditingComplete: () {
              widget.focusNode?.unfocus();
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction: widget.nextFocus == null
                ? TextInputAction.done
                : TextInputAction.next,
            validator: (value) {
              if (widget.validation == null) {
                setState(() => errorText = null);
              } else {
                setState(() => errorText = widget.validation!(value));
              }
              return errorText;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12.sp),
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscured
                  ? IconButton(
                      onPressed: () => setState(() => hidden = !hidden),
                      iconSize: 24.sp,
                      splashRadius: 1.r,
                      isSelected: !hidden,
                      color: widget.cursorColor,
                      selectedIcon: const Icon(Icons.visibility),
                      icon: SvgPicture.asset(SvgAssets.visibilityOff),
                    )
                  : widget.suffixIcon,
              hintStyle:
                  widget.hintTextStyle ??
                  getRegularStyle(
                    color: ColorManager.black,
                  ).copyWith(fontSize: 18.sp),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorStyle: TextStyle(
                fontSize: FontSize.s0,
                color: ColorManager.transparent,
              ),
            ),
          ),
        ),
        errorText == null
            ? const SizedBox()
            : Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 8.h,
                  start: 8.w,
                ),
                child: Text(
                  errorText!,
                  style: getMediumStyle(
                    color: ColorManager.error,
                  ).copyWith(fontSize: 18.sp),
                ),
              ),
      ],
    );
  }
}
