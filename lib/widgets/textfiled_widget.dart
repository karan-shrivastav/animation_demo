import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfiledWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Color selectedColor;
  final String hintText;
  final ValueChanged<String>? onChanged;
  const TextfiledWidget({
    super.key,
    required this.selectedColor,
    required this.hintText,
    this.controller,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: selectedColor,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: selectedColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: selectedColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
