import 'package:cesta_web/src/widgets/screen_size_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: Center(
        child: ScreenSizeWidget(
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
                const Text("Recuperar Senha", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Text(
                  "Digite seu e-mail cadastrado e enviaremos um link para redefinir sua senha.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                CustomInput(label: "Email", hintText: "Digite seu email", controller: emailController),
                const SizedBox(height: 20),

                CustomButton(
                  text: "Enviar link de recuperação",
                  onPressed: () {
                    // Depois do envio, navega pra tela de nova senha (simulação)
                    Navigator.pushNamed(context, '/new_password');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
