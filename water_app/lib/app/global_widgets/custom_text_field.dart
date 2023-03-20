import "package:flutter/material.dart";

class CustomTextField extends StatelessWidget {
  final String? name;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  const CustomTextField({
    super.key,
    @required this.name,
    @required this.controller,
    this.keyboardType,
    this.validator,
    this.initialValue,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: name,
          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          fillColor: Colors.white54,
          filled: true,
          hintText: name,
        ),
        controller: controller,
        keyboardType: keyboardType,
        enableSuggestions: false,
        validator: validator,
        textCapitalization: TextCapitalization.words,
        onChanged: onChanged,
      ),
    );
  }
}
