import 'package:flutter/material.dart';

class AttendanceListItem extends StatelessWidget {
  final String date;
  final String name;
  final bool isPresent;

  const AttendanceListItem({
    Key? key,
    required this.date,
    required this.name,
    required this.isPresent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            width: 50,
            height: 20,
            color: isPresent ? const Color(0xFF44E91F) : const Color(0xFFF32929),
          ),
        ],
      ),
    );
  }
}