import 'package:app_localization/src/config/app_color.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const AppTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.controller,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  Color bgColor = Colors.white38;
  Color borderColor = Colors.white38;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          borderColor = Colors.redAccent;
        });
      } else {
        setState(() {
          borderColor = Colors.white38;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      cursorColor: AppColor.primary,
      decoration: InputDecoration(
        focusColor: Colors.red,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primary,
            width: 1.0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.black,
            width: 1.0,
          ),
        ),
        hintText: widget.label,
      ),
      obscureText: widget.obscureText,
    );
  }
}
