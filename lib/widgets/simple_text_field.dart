import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onTap;
  final bool readOnly;
  final Widget prefix;
  final Widget suffix;
  final bool doValidation;
  final String hint;

  const SimpleTextField({
    Key key,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.prefix,
    this.suffix,
    this.doValidation = true,
    this.hint = "",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      validator: (value) =>
          value.isEmpty && doValidation ? 'Please input required field' : null,
      decoration: InputDecoration(
        prefixIcon: prefix,
        hintText: hint,
        suffixIcon: suffix,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}
