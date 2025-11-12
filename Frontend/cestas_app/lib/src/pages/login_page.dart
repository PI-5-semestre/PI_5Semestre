import 'package:core/features/auth/domain/user.dart';
import 'package:core/features/auth/presentation/providers/auth_provider.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:core/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  String? _errorMessage;
  bool _isRedirecting = false;

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = userController.text.trim();
    final password = passController.text.trim();
    
    // Limpa erro anterior
    setState(() {
      _errorMessage = null;
    });
    
    // Validação manual
    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, digite seu e-mail';
      });
      return;
    }
    
    if (!email.contains('@')) {
      setState(() {
        _errorMessage = 'Por favor, digite um e-mail válido';
      });
      return;
    }
    
    if (password.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, digite sua senha';
      });
      return;
    }
    
    if (password.length < 6) {
      setState(() {
        _errorMessage = 'A senha deve ter pelo menos 6 caracteres';
      });
      return;
    }
    
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
                child: Text(
                  "Igreja Comunidade Cristã",
                  style: TextStyle(color: Color(0xFF6A7282)),
                ),
              ),
              const SizedBox(height: 30),

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

              // Exibe mensagem de erro de validação manual
              if (_errorMessage != null)
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
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Exibe mensagem de erro do provider
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

              // Botão de entrar ou loading
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
                    context.go('/more/register');
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
    );
  }

  String _getErrorMessage(Object? error) {
    if (error == null) {
      return 'Ocorreu um erro desconhecido';
    }
    
    final errorString = error.toString();
    if (errorString.contains('Exception: ')) {
      return errorString.replaceFirst('Exception: ', '');
    }
    return errorString;
  }
}