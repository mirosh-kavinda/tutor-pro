import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';

class LoginInputView extends StatelessWidget {
  final String typeId;

  LoginInputView({super.key, required this.typeId});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_page_header.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_container.png'),
                  fit: BoxFit.cover,
                ),
                color: Color(0xFF0066CC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    typeId == 'teacher'
                        ? "Welcome Back Teacher "
                        : "Welcome BackStudent",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _usernameController,
                          label: 'Username',
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _passwordController,
                          label: 'Password',
                          prefixIcon: Icons.lock,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 270,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle login logic here, you can use `typeId`
                              print("Logging in as $typeId");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginInputView(typeId: "teacher")),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF06759F),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 3,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
