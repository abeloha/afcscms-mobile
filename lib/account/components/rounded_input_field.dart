import 'package:flutter/material.dart';
import 'package:AFCSCMS/account/components/text_field_container.dart';
import 'package:AFCSCMS/components/app_theme.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final initialValue;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        cursorColor: AppTheme.kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: AppTheme.kPrimaryColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
