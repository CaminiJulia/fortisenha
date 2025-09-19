import 'package:flutter/material.dart';
import '../theme.dart';


class FortiTextField extends StatefulWidget {
final TextEditingController controller;
final String label;
final String? hint;
final TextInputType keyboardType;
final String? Function(String?)? validator;
final bool isPassword;


const FortiTextField({
super.key,
required this.controller,
required this.label,
this.hint,
this.keyboardType = TextInputType.text,
this.validator,
this.isPassword = false,
});


@override
State<FortiTextField> createState() => _FortiTextFieldState();
}


class _FortiTextFieldState extends State<FortiTextField> {
bool _obscure = true;


@override
Widget build(BuildContext context) {
return TextFormField(
controller: widget.controller,
keyboardType: widget.keyboardType,
obscureText: widget.isPassword ? _obscure : false,
validator: widget.validator,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: widget.label,
hintText: widget.hint,
suffixIcon: widget.isPassword
? IconButton(
icon: Icon(_obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded, color: kFortiYellow),
onPressed: () => setState(() => _obscure = !_obscure),
)
: null,
),
);
}
}