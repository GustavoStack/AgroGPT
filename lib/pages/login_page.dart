import 'package:chatgpt_flutter_app/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ChatPage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Login failed. Please check your credentials.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Color.fromARGB(
            255, 2, 175, 60), // Altere a cor da barra de navegação
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(), // Adicione uma borda ao campo
              ),
            ),
            const SizedBox(height: 10), // Adicione um espaço entre os campos
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(), // Adicione uma borda ao campo
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 2, 175, 60), // Altere a cor do botão
                textStyle: TextStyle(
                    fontSize: 18), // Altere o tamanho do texto do botão
              ),
            ),
            const SizedBox(height: 10), // Adicione um espaço abaixo do botão
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text(
                'Don\'t have an account? Register',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 2, 175, 60)), // Altere a cor do texto do botão
              ),
            ),
          ],
        ),
      ),
    );
  }
}
