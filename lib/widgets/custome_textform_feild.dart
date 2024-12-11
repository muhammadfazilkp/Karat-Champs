import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.top,
    this.initialValue,
    this.readOnly = false,
    this.controller,
    required this.focusNode,
    this.nextNode,
    required this.textInputType,
    this.maxLines,
    this.textCapitalization = TextCapitalization.sentences,
    required this.onSaved,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final String hint;
  final double top;
  final String? initialValue;
  final bool readOnly;
  final TextEditingController? controller;
  final int? maxLines;
  final FocusNode focusNode;
  final FocusNode? nextNode;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final FormFieldSetter<String> onSaved;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: top),
      padding: const  EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        // color: Palette.primary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Color(0x14FFFFFF),
            offset: Offset(-6, -6),
          ),
          BoxShadow(
            blurRadius: 15,
            color: Color(0x2E000000),
            offset: Offset(8, 8),
          ),
        ],
      ),
      child: TextFormField(
        cursorColor: Colors.white,
        readOnly: readOnly,
        initialValue: controller == null ? initialValue : null,
        controller: controller,
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hint,
          hintStyle: const  TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          contentPadding:
             const   EdgeInsets.only(left: 25, right: 25, top: 6, bottom: 6),
          errorMaxLines: 2,
          isDense: true,
        ),
        style: const  TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        keyboardType: textInputType,
        focusNode: focusNode,
        textInputAction:
            nextNode != null ? TextInputAction.next : TextInputAction.done,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}
