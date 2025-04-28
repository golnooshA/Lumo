import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLogin = true; // To toggle between login/register

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),

            // Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 12),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Forgot password logic here
                },
                child: const Text('Forgot Password?'),
              ),
            ),

            const SizedBox(height: 16),

            // Login/Register Button
            ElevatedButton(
              onPressed: () {
                // Handle login/register logic
              },
              child: Text(isLogin ? 'Login' : 'Register'),
            ),
            const SizedBox(height: 24),

            // Divider
            Row(
              children: const [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('OR'),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 24),

            // Google Button
            OutlinedButton.icon(
              icon: Image.asset('assets/icon/google_icon.png', height: 24),
              label: const Text('Continue with Google'),
              onPressed: () {},
            ),
            const SizedBox(height: 12),

            // Facebook Button
            OutlinedButton.icon(
              icon: Image.asset('assets/icon/facebook_icon.png', height: 24),
              label: const Text('Continue with Facebook'),
              onPressed: () {},
            ),

            const Spacer(),

            // Switch between login/register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isLogin ? "Don't have an account?" : "Already have an account?"),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin ? 'Register' : 'Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
