import 'package:cesta_web/src/widgets/screen_size_widget.dart';
import 'package:core/features/user/data/models/create_user.dart';
import 'package:core/features/user/providers/user_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class NewServantPage extends ConsumerStatefulWidget {
  const NewServantPage({super.key});

  @override
  ConsumerState<NewServantPage> createState() => _NewServantPageState();
}

class _NewServantPageState extends ConsumerState<NewServantPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    cpfController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(userControllerProvider);
    final controller = ref.read(userControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: ScreenSizeWidget(
            child: Column(
              children: [
                _buildCardHeader(),
            
                _buildSection(
                  title: "Informações de Acesso",
                  icon: Icons.login,
                  children: [
                    _buildTextField(
                      "E-mail *",
                      controller: emailController,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório"),
                        Validatorless.email("E-mail inválido"),
                      ]),
                    ),
                    _buildTextField(
                      "Senha *",
                      controller: passwordController,
                      obscure: true,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório"),
                        Validatorless.min(6, "Mínimo 6 caracteres"),
                      ]),
                    ),
                    _buildTextField(
                      "Confirme sua senha *",
                      controller: confirmPasswordController,
                      obscure: true,
                      validator: Validatorless.compare(
                        passwordController,
                        "As senhas não coincidem",
                      ),
                    ),
                  ],
                ),
            
                _buildSection(
                  title: "Informações Pessoais",
                  icon: Icons.person,
                  children: [
                    _buildTextField(
                      "Nome *",
                      controller: nameController,
                      validator: Validatorless.required("Campo obrigatório"),
                    ),
                    _buildTextField(
                      "CPF *",
                      controller: cpfController,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório"),
                        Validatorless.min(11, "CPF deve ter 11 dígitos"),
                        Validatorless.max(11, "CPF deve ter 11 dígitos"),
                        Validatorless.regex(RegExp(r'^\d{11}'), "Apenas números, 11 dígitos"),
                      ]),
                    ),
                    _buildTextField(
                      "Telefone *",
                      controller: phoneController,
                        validator: Validatorless.multiple([
                          Validatorless.required("Campo obrigatório"),
                          Validatorless.min(10, "Mínimo 11 dígitos"),
                          Validatorless.max(11, "Máximo 11 dígitos"),
                          Validatorless.regex(RegExp(r'^\d+$'), "Apenas números"),
                        ]),
                    ),
                  ],
                ),
            
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: state.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.check),
        onPressed: state.isLoading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  final dto = CreateUser(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    name: nameController.text.trim(),
                    cpf: cpfController.text.trim(),
                    mobile: phoneController.text.trim(),
                    account_type: "VOLUNTEER",
                    institution_id: 1,
                  );

                  await controller.createUser(dto);

                  if (ref.read(userControllerProvider).error == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Usuário criado com sucesso!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: theme.colorScheme.onPrimary,
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(ref.read(userControllerProvider).error!, 
                            style: TextStyle(color: theme.colorScheme.onError),
                          ),
                          backgroundColor: theme.colorScheme.error,
                      ),
                    );
                  }
                }
              },
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Novo Funcionário',
      subtitle: 'Cadastro para novos funcionários',
      colors: const [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: Icons.work,
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}