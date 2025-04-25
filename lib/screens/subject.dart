import 'package:flutter/material.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.207,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/https://cdn.builder.io/api/v1/image/assets/TEMP/38381a9e7903f1e9f87ae65c70b324fe0589b04f?placeholderIfAbsent=true',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 15, 22, 278),
                      child: Image.asset(
                        'assets/images/https://cdn.builder.io/api/v1/image/assets/TEMP/f62cb6515314d69114d0bb2e484819f1bd75d70f?placeholderIfAbsent=true',
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -120),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/https://cdn.builder.io/api/v1/image/assets/TEMP/acea42945aa66acb63cc8c39bc428ec3dd0d99d6?placeholderIfAbsent=true',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(32, 36, 32, 62),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                'Subjects',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 14),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Grade 6',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Row(
                              children: [
                                Expanded(
                                  child: _SubjectCard(
                                    imagePath: 'assets/images/https://cdn.builder.io/api/v1/image/assets/TEMP/93445accb10d5a9984090a53bdaa92f20950c71c?placeholderIfAbsent=true',
                                    subject: 'Mathematics',
                                  ),
                                ),
                                SizedBox(width: 46),
                                Expanded(
                                  child: _SubjectCard(
                                    imagePath: 'assets/images/https://cdn.builder.io/api/v1/image/assets/TEMP/93445accb10d5a9984090a53bdaa92f20950c71c?placeholderIfAbsent=true',
                                    subject: 'Sinhala',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 38),
                            Row(
                              children: [
                                Expanded(
                                  child: _SubjectCard(
                                    imagePath: 'assets/images/https://cdn.builder.io/api/v1/image/assets/TEMP/93445accb10d5a9984090a53bdaa92f20950c71c?placeholderIfAbsent=true',
                                    subject: 'Science',
                                  ),
                                ),
                                SizedBox(width: 46),
                                Expanded(
                                  child: _SubjectCard(
                                    imagePath: 'assets/images/https://cdn.builder.io/api/v1/image/assets/TEMP/93445accb10d5a9984090a53bdaa92f20950c71c?placeholderIfAbsent=true',
                                    subject: 'English',
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
        ),
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final String imagePath;
  final String subject;

  const _SubjectCard({
    Key? key,
    required this.imagePath,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              width: 130,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 21),
          Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Text(
              subject,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}