import 'package:flutter/material.dart';
import '../theme/text_styles.dart';

class StudentsView extends StatelessWidget {
  const StudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: const BoxConstraints(maxWidth: 480),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.444,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/4a19bf6ead13c3d45d9af1b9bc2b649abbf382b9?placeholderIfAbsent=true',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 225),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/f62cb6515314d69114d0bb2e484819f1bd75d70f?placeholderIfAbsent=true',
                      width: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 0.605,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/7d7bff14e96e9432fed142cd5f225814ae754816?placeholderIfAbsent=true',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 98),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 19,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'VIEW ATTENDENCE',
                            style: AppTextStyles.buttonText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 29, 14, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Student List',
                              style: AppTextStyles.heading,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 26, top: 30),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 132,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'S.No',
                                          style: AppTextStyles.listText,
                                        ),
                                        Text(
                                          'Name',
                                          style: AppTextStyles.listText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 12),
                                width: 276,
                                height: 3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                      9,
                                      (index) => const Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          '0001',
                                          style: AppTextStyles.listText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 176,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Avishka',
                                                  style: AppTextStyles.listText,
                                                ),
                                                ...List.generate(
                                                  8,
                                                  (index) => const Padding(
                                                    padding:
                                                        EdgeInsets.only(
                                                            top: 10),
                                                    child: Text(
                                                      'Lorem spein',
                                                      style:
                                                          AppTextStyles.listText,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: List.generate(
                                                9,
                                                (index) => const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10),
                                                  child: Text(
                                                    'VIEW',
                                                    style: AppTextStyles.listText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 30),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'ADD STUDENTS',
                                          style: AppTextStyles.buttonText,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}