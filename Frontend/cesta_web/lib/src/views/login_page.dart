import 'package:core/features/auth/data/models/user.dart';
import 'package:core/features/auth/providers/auth_provider.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  bool _isRedirecting = false;

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // ✔ agora usa validação do Form + Validatorless
    if (_formKey.currentState?.validate() != true) return;

    final email = userController.text.trim();
    final password = passController.text.trim();

    await ref.read(authProvider.notifier).login(email, password);
  }

  void _redirectToHome() {
    if (!_isRedirecting && mounted) {
      _isRedirecting = true;
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AsyncValue<User?>>(authProvider, (previous, next) {
      next.whenData((user) {
        if (user != null) {
          _redirectToHome();
        }
      });
    });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey, // ✔ aqui
            child: Container(
              width: 350,
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
                    margin: const EdgeInsets.all(4),
                    child: const Text(
                      "Igreja Comunidade Cristã",
                      style: TextStyle(color: Color(0xFF6A7282)),
                    ),
                  ),
                  const SizedBox(height: 30),
              
                  TextFormField(
                    controller: userController,
                    decoration: const InputDecoration(
                      labelText: "Usuário",
                      hintText: "Digite seu usuário",
                      border: OutlineInputBorder(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required("Informe o e-mail"),
                      Validatorless.email("E-mail inválido"),
                    ]),
                  ),
              
                  const SizedBox(height: 16),
              
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Senha",
                      hintText: "Digite sua senha",
                      border: OutlineInputBorder(),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required("Informe sua senha"),
                      Validatorless.min(6, "Mínimo 6 caracteres"),
                    ]),
                  ),
              
                  const SizedBox(height: 20),
              
                  if (authState is AsyncError)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Text(
                        _getErrorMessage(authState.error),
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
              
                  // Botão
                  if (authState is AsyncLoading)
                    const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      ),
                    )
                  else
                    CustomButton(
                      text: "Entrar",
                      color: Colors.blueAccent,
                      onPressed: _login,
                    ),
              
                  const SizedBox(height: 30),
              
                  if (authState is! AsyncLoading) ...[
                    GestureDetector(
                      onTap: () {
                        context.push('/forgot_password');
                      },
                      child: const Text(
                        "Esqueci minha senha",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        context.go('/register');
                      },
                      child: const Text(
                        "Não tem conta? Cadastre-se",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
              
                  const SizedBox(height: 20),
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
        ),
      ),
    );
  }

  String _getErrorMessage(Object? error) {
    if (error == null) return "Ocorreu um erro desconhecido";

    final text = error.toString();
    if (text.contains("Exception: ")) {
      return text.replaceFirst("Exception: ", "");
    }
    return text;
  }
}
