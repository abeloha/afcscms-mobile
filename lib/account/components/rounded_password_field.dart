import 'package:flutter/material.dart';
import 'package:AFCSCMS/account/components/text_field_container.dart';
import 'package:AFCSCMS/components/app_theme.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final initialValue;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: widget.initialValue,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        cursorColor: AppTheme.kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: AppTheme.kPrimaryColor,
          ),
          suffixIcon: IconButton(
            onPressed: () => _toggle(),
            icon: Icon(Icons.visibility, color: AppTheme.kPrimaryColor),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
