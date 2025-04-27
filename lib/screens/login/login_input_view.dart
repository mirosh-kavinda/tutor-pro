import 'package:flutter/material.dart';
import '../../repository/handleAuthLogin.dart';
import '../../widgets/custom_text_field.dart';

class LoginInputView extends StatefulWidget {
  final String typeId;

  const LoginInputView({super.key, required this.typeId});

  @override
  _LoginInputViewState createState() => _LoginInputViewState();
}

class _LoginInputViewState extends State<LoginInputView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    setState(() {
      _isButtonEnabled = (widget.typeId != "admin" &&
              _usernameController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty) ||
          widget.typeId == "admin" && _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: 40,
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
                  const Text(
                    " WELCOME BACK TO NENEKRA EDUCATION INSTITUTE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
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
                        if (widget.typeId != "admin")
                          CustomTextField(
                            controller: _usernameController,
                            label: 'Username',
                            prefixIcon: Icons.person,
                          ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          isPassword: true,
                          controller: _passwordController,
                          label: 'Password',
                          prefixIcon: Icons.lock,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 270,
                          child: ElevatedButton(
                            onPressed: _isButtonEnabled
                                ? () => userAuth(
                                    context,
                                    widget.typeId,
                                    _usernameController.text,
                                    _passwordController.text)
                                : null,
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
