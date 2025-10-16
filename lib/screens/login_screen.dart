import 'package:flutter/material.dart';
import '../widgets/my_button.dart';
import '../widgets/my_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _login() {
    setState(() {
      isLoading = true;
    });

    // Simulate login
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });

      final email = emailController.text;
      final password = passwordController.text;

      if (email == "test@test.com" && password == "1234") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyInput(
              controller: emailController,
              hintText: "Email",
            ),
            const SizedBox(height: 16),
            MyInput(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 24),
            MyButton(
              text: "Login",
              onPressed: _login,
              type: ButtonType.filled,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
