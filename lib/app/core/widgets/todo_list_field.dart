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

  TodoListField({
    required this.label,
    this.controller,
    this.obscureText = false,
    this.suffixIconButton,
    this.validator,
    this.focusNode,
    Key? key,
  })  : assert(
          obscureText ? suffixIconButton == null : true,
          'obscureText não pode ser enviado com suffixIconButton',
        ),
        _obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  _TodoListFieldState createState() => _TodoListFieldState();
}

class _TodoListFieldState extends State<TodoListField> {
  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget._obscureTextVN,
      builder: (_, obscureTextValue, __) => TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIconButton ??
              (widget.obscureText
                  ? IconButton(
                      onPressed: () =>
                          widget._obscureTextVN.value = !obscureTextValue,
                      icon: Icon(
                        !obscureTextValue
                            ? TodoListIcons.eyeSlash
                            : TodoListIcons.eye,
                        size: 15,
                      ),
                    )
                  : null),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.red),
          ),
          labelText: widget.label,
          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
          isDense: true,
        ),
        obscureText: obscureTextValue,
      ),
    );
  }
}
