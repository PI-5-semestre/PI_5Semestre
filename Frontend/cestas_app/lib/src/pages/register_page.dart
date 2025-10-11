import 'package:core/widgets/button_widget.dart';
import 'package:core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = TextEditingController();
    final emailController = TextEditingController();
    final passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Criar Conta", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                CustomInput(label: "Usuário", hintText: "Digite seu usuário", controller: userController),
                const SizedBox(height: 16),
                CustomInput(label: "Email", hintText: "Digite seu email", controller: emailController),
                const SizedBox(height: 16),
                CustomInput(label: "Senha", hintText: "Digite sua senha", obscureText: true, controller: passController),
                const SizedBox(height: 20),

                CustomButton(text: "Cadastrar", onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
