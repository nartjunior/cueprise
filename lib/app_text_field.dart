import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.textFieldFocusNode,
    this.obscureText = false,
    this.toggleObscured,
    required this.hintText,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.suffixIcon2,
    this.errorText,
    this.onChanged,
    required this.nextAction,
    this.inputFormatters,

  });

  final FocusNode? textFieldFocusNode;
  final bool? obscureText;
  final void Function()? toggleObscured;
  final String hintText;
  final String title;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final IconData? suffixIcon2;
  final void Function(String)? onChanged;
  final String? errorText;
  final TextInputAction nextAction;
  final List<TextInputFormatter>? inputFormatters;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Text(
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            title,
          ),
        ),
        TextFormField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText!,
          focusNode: textFieldFocusNode,
          textInputAction: nextAction,
          decoration: InputDecoration(
              errorText: errorText,
              errorMaxLines: 3,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              hintText: hintText,
              isDense: true,
              // Reduces height a bit
              border: InputBorder.none,
              suffixIcon: suffixIcon2 == null ? null : Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: toggleObscured,
                  child: Icon(suffixIcon2, size: 24, color: Theme.of(context).colorScheme.secondary),
                ),
              )
          ),
        ),
      ],
    );
  }
}
