import 'package:flutter/material.dart';
import '../login/login_dashboard.dart';
import '../../styles/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startLoadingAndNavigate(); // Automatically call the method when the page loads
  }

  void _startLoadingAndNavigate() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds:2)); // Simulate loading

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreenDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: Styles.homeContainer,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Styles.containerStyle['maxWidth'],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: Styles.imageContainerStyle['aspectRatio'],
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/onboard_container.png',
                                fit: Styles.backgroundImageStyle['fit'],
                              ),
                            ),
                            Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: Styles.profileImageStyle['aspectRatio'],
                                  child: ClipRRect(
                                    borderRadius: Styles.profileImageStyle['borderRadius'],
                                    child: Image.asset(
                                      'assets/images/onboarding_character.png',
                                      fit: Styles.profileImageStyle['fit'],
                                    ),
                                  ),
                                ),
                                SizedBox(height: Styles.textContainerStyle['marginTop']),
                                Container(
                                  margin: EdgeInsets.only(
                                    right: Styles.textContainerStyle['marginRight'],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'NENEKRA',
                                        style: Styles.titleText,
                                      ),
                                      Text(
                                        'EDUCATION INSTITUTE',
                                        style: Styles.subtitleText,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Styles.imageContainerStyle['paddingBottom']),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Overlay with spinner animation
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}