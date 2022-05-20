import 'package:brasil_fields/brasil_fields.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInputWidget extends StatefulWidget {
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintText;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormaters;
  final Function(String?)? onFieldSubmitted;
  final Function(String?) onChanged;
  final TextEditingController textEditingController;
  final String? campoVazio;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  final Function()? onTap;
  final void Function()? onEditingComplete;

  const MyInputWidget({
    Key? key,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.inputFormaters,
    this.onFieldSubmitted,
    required this.onChanged,
    required this.textEditingController,
    this.campoVazio,
    required this.formKey,
    this.autovalidateMode,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<MyInputWidget> createState() => _MyInputWidgetState();
}

class _MyInputWidgetState extends State<MyInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
      child: TextFormField(
        onEditingComplete: widget.onEditingComplete,
        textCapitalization: widget.textCapitalization,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.campoVazio;
          }
          if (widget.label == 'CNPJ' && !CNPJValidator.isValid(value)) {
            return 'CNPJ Inválido';
          }
          return null;
        },
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          widget.onChanged(value);
          setState(() {});
        },
        onTap: widget.onTap,
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormaters,
        onFieldSubmitted: widget.onFieldSubmitted,
        maxLength: widget.maxLength,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          label: Text(widget.label),
          suffixIcon: widget.suffixIcon,
          filled: true,
          isDense: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: widget.textEditingController.text.isNotEmpty
                  ? AppTheme.colors.primary
                  : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
