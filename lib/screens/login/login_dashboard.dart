import 'package:flutter/material.dart';
import 'login_input_view.dart';

class LoginScreenDashboard extends StatelessWidget {
  const LoginScreenDashboard({super.key});

  void _navigateToTeacherLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginInputView(typeId: "teacher")),
    );
  }

  void _navigateToStudentLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginInputView(typeId: "student")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top illustration
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/login_page_header.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          // Back arrow
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Bottom container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_container.png'),
                  fit: BoxFit
                      .cover, // Adjust the fit as needed (cover, contain, etc.)
                ),
                color: Color(0xFF0066CC), // Optional background color
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "WELCOME TO NENEKRA\nEDUCATION INSTITUTE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily:'Poppins' ,
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Teacher button
                  SizedBox(
                    width: 270,
                    child: ElevatedButton.icon(
                      onPressed: () => _navigateToTeacherLogin(context),
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 30,
                      ),
                      label: const Text(
                        'Login as Teacher',
                        style: TextStyle(color: Colors.black,
                        fontFamily: 'Poppins',fontSize: 16 , fontWeight: FontWeight.bold ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Student button
                  SizedBox(
                    width: 270,
                    child: ElevatedButton.icon(
                      onPressed: () => _navigateToStudentLogin(context),
                      icon: const Icon(Icons.person, color: Colors.black),
                      label: const Text(
                        'Login as Student',
                        style: TextStyle(color: Colors.black,
                        fontFamily: 'Poppins',fontSize: 16 , fontWeight: FontWeight.bold 
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
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
