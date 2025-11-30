import 'package:cesta_web/src/widgets/screen_size_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final senhaController = TextEditingController();
    final confirmarController = TextEditingController();

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
                const Text("Crie sua nova senha", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                CustomInput(
                  label: "Nova Senha",
                  hintText: "Digite a nova senha",
                  obscureText: true,
                  controller: senhaController,
                ),
                const SizedBox(height: 16),
                CustomInput(
                  label: "Confirmar Senha",
                  hintText: "Confirme a nova senha",
                  obscureText: true,
                  controller: confirmarController,
                ),
                const SizedBox(height: 20),

                CustomButton(
                  text: "Alterar Senha",
                  onPressed: () {
                    if (senhaController.text == confirmarController.text && senhaController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Senha alterada com sucesso!")),
                      );
                      Navigator.pop(context); // volta pra login
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("As senhas não coincidem.")),
                      );
                    }
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
