import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.label,
    this.isPassword = false,
    this.controller, required IconData prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20), // Add horizontal spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              filled: true,
              fillColor: Color(0xFFF2F2F2), // Light gray background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.black26, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.black26, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.black87, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
