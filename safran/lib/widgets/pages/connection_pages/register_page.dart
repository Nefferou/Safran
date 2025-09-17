import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safran/api/api_service.dart';
import '../home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void register() async {
    setState(() => isLoading = true);
    final result = await ApiService.register(
      emailController.text,
      usernameController.text,
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

  void goToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: usernameController, decoration: const InputDecoration(labelText: 'Nom utilisateur')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Mot de passe'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: isLoading ? null : register, child: isLoading ? const CircularProgressIndicator() : const Text('Inscription')),
            const SizedBox(height: 10),
            TextButton(
              onPressed: goToLogin,
              child: const Text("Déja un compte ? Connectez-vous"),
            ),
          ],
        ),
      ),
    );
  }
}