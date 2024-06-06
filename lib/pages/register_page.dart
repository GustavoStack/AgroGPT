import 'package:chatgpt_flutter_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'name': _nameController.text,
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Registration failed. Please try again.',
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
        title: const Text('Register'),
        backgroundColor: Color.fromARGB(
            255, 2, 175, 60), // Altere a cor da barra de navegação
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(), // Adicione uma borda ao campo
              ),
            ),
            const SizedBox(height: 10), // Adicione um espaço entre os campos
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
              onPressed: _register,
              child: const Text('Register'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 2, 175, 60), // Altere a cor do botão
                textStyle: TextStyle(
                    fontSize: 18), // Altere o tamanho do texto do botão
              ),
            ),
          ],
        ),
      ),
    );
  }
}
