import "package:flutter/material.dart";

class CustomForm extends StatelessWidget {
  final String? name;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<dynamic>? onChanged;
  const CustomForm(
      {super.key,
      @required this.name,
      @required this.onChanged,
      this.keyboardType,
      this.validator,
      this.initialValue});
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          fillColor: Colors.white54,
          filled: true,
          hintText: name,
        ),
        keyboardType: keyboardType,
        enableSuggestions: false,
        validator: validator,
        textCapitalization: TextCapitalization.words,
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }
}
