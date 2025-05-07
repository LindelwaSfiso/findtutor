import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final TextEditingController inputController;
  final String label;
  final bool isLoading;
  final String? inputError;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool showPasswordToggle;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;

  const InputText({
    super.key,
    required this.inputController,
    required this.isLoading,
    required this.label,
    required this.inputError,
    this.prefixIcon,
    this.isPassword = false,
    this.showPasswordToggle = false,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    isPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      enabled: !widget.isLoading,
      obscureText: widget.isPassword
          ? widget.showPasswordToggle
              ? !isPasswordVisible
              : false
          : false,
      controller: widget.inputController,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        errorText:
            (widget.inputError?.isNotEmpty == true) ? widget.inputError : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: const EdgeInsets.all(15),
        suffixIcon: widget.showPasswordToggle
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }
}
