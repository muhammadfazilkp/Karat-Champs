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
      margin: EdgeInsets.only(left: 5.0, right: 5.0, top: top),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          // borderRadius: BorderRadius.circular(18),

          color: const Color.fromARGB(255, 218, 214, 214)),
      child: TextFormField(
        cursorColor: Colors.white,
        readOnly: readOnly,
        initialValue: controller == null ? initialValue : null,
        controller: controller,
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          errorMaxLines: 2,
          isDense: true,
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
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
