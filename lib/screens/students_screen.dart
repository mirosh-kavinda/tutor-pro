import 'package:flutter/material.dart';
import '../widgets/grade_card_widgets.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: const BoxConstraints(maxWidth: 480),
      width: double.infinity,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.27,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/5adf0ba9d7999134c7e6bee1cdb998e51cb8ff29?placeholderIfAbsent=true&apiKey=1ea246e03b424a6ea478dd7a91974dba',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 17,
                  left: 23,
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/f62cb6515314d69114d0bb2e484819f1bd75d70f?placeholderIfAbsent=true&apiKey=1ea246e03b424a6ea478dd7a91974dba',
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -102),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/c1d3e958b302895b646f08e8d055671fd6c2608c?placeholderIfAbsent=true&apiKey=1ea246e03b424a6ea478dd7a91974dba',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(33, 39, 33, 76),
                    child: Column(
                      children: [
                        Text(
                          'Classes',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: GradeCardWidget(
                                gradeNumber: '6',
                                imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/3990f205f7ff00e997615ae0e3382428fe297e49?placeholderIfAbsent=true&apiKey=1ea246e03b424a6ea478dd7a91974dba',
                              ),
                            ),
                            SizedBox(width: 46),
                            Expanded(
                              child: GradeCardWidget(
                                gradeNumber: '7',
                                imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/3990f205f7ff00e997615ae0e3382428fe297e49?placeholderIfAbsent=true&apiKey=1ea246e03b424a6ea478dd7a91974dba',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 38),
                        Row(
                          children: [
                            Expanded(
                              child: GradeCardWidget(
                                gradeNumber: '8',
                                imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/3990f205f7ff00e997615ae0e3382428fe297e49?placeholderIfAbsent=true&apiKey=1ea246e03b424a6ea478dd7a91974dba',
                              ),
                            ),
                            SizedBox(width: 46),
                            Expanded(
                              child: GradeCardWidget(
                                gradeNumber: '9',
                                imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/3990f205f7ff00e997615ae0e3382428fe297e49?placeholderIfAbsent=true&apiKey=1ea246e03b424a6ea478dd7a91974dba',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}