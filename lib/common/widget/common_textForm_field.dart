

import 'package:flutter/material.dart';
import 'package:image_task/image_task.dart';


class CommonTextFiled extends StatelessWidget {
  final String? heading;
  final Color headingTextColor;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixWidget;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onTap;
  bool secureText;
  bool isNumberOnly;
  bool isDecimal;
  bool isPincodeOnly;
  bool onlyNumber;
  TextInputType? textInputType;
  bool isMobileNumber;
  String errorText;
  final int maxLines;
  final int minLines;
  final double suffixMaxWidth;
  final double? leftPadding;
  final bool isEnabled;
  final bool isReadOnly;
  final bool isMandatory;
  double fullHeight;
  double textFieldHeight;
  double fontSize;
  double hintFontSize;
  final double errorFontSize;
  final Function(String)? onChanged;
  final int maxTextLength;


  CommonTextFiled({
    Key? key,
    this.isEnabled = true,
    this.headingTextColor = Colors.black,
    this.isReadOnly = false,
    this.secureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputType,
    this.isMobileNumber = false,
    this.heading,
    this.isNumberOnly = false,
    this.isDecimal = false,
    this.isPincodeOnly = false,
    this.onlyNumber = false,

    this.controller,
    this.hintText,
    this.suffixWidget,
    this.suffixMaxWidth = 50,
    this.leftPadding,
    this.errorText = "",
    this.isMandatory = false,
    this.fullHeight = 80,
    this.textFieldHeight = 40,
    this.fontSize = 14,
    this.hintFontSize = 12,
    this.errorFontSize = 13,
    this.onSuffixTap,
    this.onTap,
    this.onChanged,
    this.maxTextLength = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fullHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    heading ?? "",
                    style: TextStyle(color: headingTextColor),
                  ),
                  if (heading!.isNotEmpty && isMandatory)
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          inkWell(
            onTap: onTap,
            child: Container(
              height: textFieldHeight,
              padding: EdgeInsets.only(
                  left: leftPadding ?? 5.56.w, right: 2.w, bottom: 7),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [commonBoxShadow()]),
              child: TextFormField(
                keyboardType: textInputType,
                inputFormatters: [
                  if (isNumberOnly)
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    LengthLimitingTextInputFormatter(isMobileNumber  ? 10 : maxTextLength),


                  if(isDecimal)
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),

                  if(isPincodeOnly)
                    LengthLimitingTextInputFormatter(6),

                  if(onlyNumber)
                    FilteringTextInputFormatter.digitsOnly,

                  // FilteringTextInputFormatter.allow(RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$')),
                  // FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$')),


                ],
                onTap: onTap,

                obscureText: secureText,
                obscuringCharacter: '*',
                controller: controller,
                onChanged: onChanged,
                enabled: isEnabled,
                readOnly: isReadOnly,
                style: TextStyle(fontSize: fontSize,color: Colors.blue),
                cursorColor: Colors.blue,
                // minLines: 1,
                maxLines: maxLines,

                minLines: minLines,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(color: const Color(0XFF262626).withOpacity(0.5), fontSize: hintFontSize),
                  suffixIcon: inkWell(
                    onTap: onSuffixTap,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: suffixWidget,
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(maxWidth: 50),
                ),
              ),
            ),
          ),
          ErrorText(errorText: errorText, errorFontSize: errorFontSize),
        ],
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder(Color borderColor) => OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      // borderSide: BorderSide(color: Color(0XFF898989)),
      borderSide: BorderSide(color: borderColor),
    );

class ErrorText extends StatelessWidget {
  final double errorFontSize;
  final double topPadding;
  final String? errorText;

  const ErrorText(
      {super.key,
      this.errorText,
      this.errorFontSize = 13,
      this.topPadding = 5});

  @override
  Widget build(BuildContext context) {
    if ((errorText ?? '').isEmpty) {
      return const SizedBox();
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding:  EdgeInsets.only(top: topPadding),
          child: Text(
            errorText ?? "",
            maxLines: 2,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.red,
                fontSize: errorFontSize),
            textAlign: TextAlign.start,
          ),
        ),
      );
    }
  }
}

BoxShadow commonBoxShadow(
        {double firstOffset = 0,
        double secondOffset = 3,
        double blurRadius = 40,
        double spreadRadius = 0,
        double opacity = 0.12}) =>
    BoxShadow(
        color: Colors.black.withOpacity(opacity),
        offset: Offset(firstOffset, secondOffset),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius);








