  import 'package:flutter/material.dart';

  class CustomAppBar extends StatelessWidget {
  final  String title;
    const CustomAppBar({super.key , required this.title});

    @override
    Widget build(BuildContext context) {
      double cuspadding = MediaQuery.of(context).size.width <= 640 ? 15 : 20;

      return Padding(
        padding: EdgeInsets.only(top: cuspadding, bottom: cuspadding, right: cuspadding),
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