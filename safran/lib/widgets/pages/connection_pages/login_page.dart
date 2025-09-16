import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safran/api/api_service.dart';
import '../home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void login() async {
    setState(() => isLoading = true);
    final result = await ApiService.login(
      emailController.text,
      passwordController.text,
    );
    setState(() => isLoading = false);

    final token = result['data']?['token'];

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result['error'] ?? 'Erreur')));
    }
  }

  void goToRegister() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Mot de passe'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: isLoading ? null : login, child: isLoading ? const CircularProgressIndicator() : const Text('Connexion')),
            const SizedBox(height: 10),
            TextButton(
              onPressed: goToRegister,
              child: const Text("Pas de compte ? Inscrivez-vous"),
            ),
          ],
        ),
      ),
    );
  }
}