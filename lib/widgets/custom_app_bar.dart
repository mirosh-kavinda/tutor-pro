import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width <= 640;

    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            'https://cdn.builder.io/api/v1/image/assets/TEMP/b64101800f2f27c3a89ca7ddd54a16194d6cd7d3?placeholderIfAbsent=true',
            width: 30,
            height: 30,
          ),
          const Text(
            'Attendance Sheet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.network(
            'https://cdn.builder.io/api/v1/image/assets/TEMP/f2f5ebf02bf57e53b61a0f59ca6f899140338222?placeholderIfAbsent=true',
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}