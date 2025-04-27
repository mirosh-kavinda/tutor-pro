import 'package:flutter/material.dart';

class AttendanceListItem extends StatelessWidget {
  final String date;
  final String name;
  final String classId;
  final bool isPresent;

  const AttendanceListItem({
    Key? key,
    required this.date,
    required this.name,
    required this.classId,
    required this.isPresent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
           Expanded(
            flex: 2,
            child: Text(
              classId,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 50,
              height: 20,
              color:
                  isPresent ? const Color(0xFF44E91F) : const Color(0xFFF32929),
            ),
          ),
        ],
      ),
    );
  }
}
