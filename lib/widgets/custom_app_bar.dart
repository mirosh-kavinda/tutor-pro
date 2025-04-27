import 'package:flutter/material.dart';

import 'download_pdf.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
   final VoidCallback onDownloadPressed;
  const CustomAppBar({super.key, required this.title , required this.onDownloadPressed});

  @override
  Widget build(BuildContext context) {
    double cuspadding = MediaQuery.of(context).size.width <= 640 ? 15 : 20;

    return Padding(
      padding: EdgeInsets.only(
          top: cuspadding, bottom: cuspadding, right: cuspadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(color: Colors.grey), // Optional: Add a border
              borderRadius: BorderRadius.circular(100), // Add border radius
            ),
            child: IconButton(
              icon: const Icon(Icons.download, size: 22, color: Colors.white),
              onPressed: onDownloadPressed,
            ),
          ),
        ],
      ),
    );
  }
}
