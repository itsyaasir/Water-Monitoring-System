import "package:flutter/material.dart";

class CustomForm extends StatelessWidget {
  final String? name;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<dynamic>? onChanged;
  const CustomForm(
      {@required this.name,
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
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.blue[50],
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
