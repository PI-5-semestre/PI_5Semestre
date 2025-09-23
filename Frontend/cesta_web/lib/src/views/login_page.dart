import 'package:core/widgets/button_widget.dart';
import 'package:core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blueAccent,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Cestas de Amor",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text("Sistema de Gestão de Cestas Básicas"),
              Container(
                margin: EdgeInsets.all(4), // 4px em todos os lados
                child: Text(
                  "Igreja Comunidade Cristã",
                  style: TextStyle(color: Color(0xFF6A7282)),
                ),
              ),
              const SizedBox(height: 30),

              Container(
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
                  children: [
                    CustomInput(
                      label: "Usuário",
                      hintText: "Digite seu usuário",
                      controller: userController,
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      label: "Senha",
                      hintText: "Digite sua senha",
                      obscureText: true,
                      controller: passController,
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      text: "Entrar",
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              "Não tem conta? Cadastre-se",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          
                          const SizedBox(height: 10),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgot_password');
                            },
                            child: const Text(
                              "Esqueci minha senha",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '"Porque tive fome, e destes-me de comer"',
                    textAlign: TextAlign.center,
                  ),
                  Text('- Mateus 25:35', textAlign: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
