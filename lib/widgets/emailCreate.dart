import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:flutter/material.dart';

Future<bool> sendEmail(dynamic templateParams, BuildContext context) async {
  try {
    await emailjs.send(
      'service_38tmctn',
      'template_dq6wdyi',
      templateParams,
      const emailjs.Options(
        publicKey: '_E59DG2LhtPZ3Nx51',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Email Placed',
        style: TextStyle(
            fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green[400],
    ));
    return true;
  } catch (error) {
    if (error is emailjs.EmailJSResponseStatus) {
      print('ERROR... ${error.status}: ${error.text}');
    }
    print(error.toString());
    return false;
  }
}