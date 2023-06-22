import 'package:flutter/material.dart';

import '../ui/todo_list_icons.dart';

class TodoListField extends StatefulWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType keyboardType;

  TodoListField({
    required this.label,
    this.controller,
    this.obscureText = false,
    this.suffixIconButton,
    this.validator,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    super.key,
  }) : _obscureTextVN = ValueNotifier(obscureText);

  @override
  State<TodoListField> createState() => _TodoListFieldState();
}

class _TodoListFieldState extends State<TodoListField> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget._obscureTextVN,
      builder: (_, obscureTextValue, __) => TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
          isDense: true,
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () =>
                      widget._obscureTextVN.value = !obscureTextValue,
                  icon: Icon(_getIcon(obscureTextValue)),
                )
              : widget.suffixIconButton,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: obscureTextValue,
        validator: widget.validator,
      ),
    );
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  IconData _getIcon(bool show) =>
      show ? TodoListIcons.eye : TodoListIcons.eyeSlash;
}
