import 'package:core/features/family/data/models/family_model.dart';
// import 'package:core/features/family/providers/family_view_model.dart';
// import 'package:core/features/family/providers/new_family_view_model.dart';
import 'package:core/features/viacep/providers/cep_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

class NewFamilyPage extends ConsumerStatefulWidget {
  const NewFamilyPage({super.key});

  @override
  ConsumerState<NewFamilyPage> createState() => _NewFamilyPageState();
}

class _NewFamilyPageState extends ConsumerState<NewFamilyPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneController = TextEditingController();

  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final stateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cpfController.dispose();
    phoneController.dispose();
    cepController.dispose();
    streetController.dispose();
    numberController.dispose();
    neighborhoodController.dispose();
    stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final familyVm = ref.watch(newFamilyViewModelProvider.notifier);
    final cepState = ref.watch(viaCepProvider);

    /// Sempre atualiza os campos quando um CEP válido é carregado
    cepState.when(
      data: (cep) {
        if (cep != null) {
          streetController.text = cep.logradouro;
          neighborhoodController.text = cep.bairro;
          stateController.text = cep.uf;
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: ListView(
            children: [
              _buildCardHeader(),

              _buildSection(
                title: "Informações Pessoais",
                icon: Icons.person,
                children: [
                  _buildTextField(
                    "Nome do Responsável *",
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
                      Validatorless.regex(RegExp(r'^\d+$'), "Apenas números"),
                    ]),
                  ),
                  _buildTextField(
                    "Telefone",
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

              _buildSection(
                title: "Endereço",
                icon: Icons.location_on,
                children: [
                  _buildTextField(
                    "CEP",
                    controller: cepController,
                    validator: Validatorless.multiple([
                      Validatorless.required("Campo obrigatório"),
                      Validatorless.min(8, "CEP inválido"),
                      Validatorless.regex(RegExp(r'^\d+$'), "Apenas números"),
                    ]),
                    onChanged: (value) {
                      if (value.length == 8) {
                        ref.read(viaCepProvider.notifier).fetchCep(value);
                      }
                    },
                  ),
                  _buildTextField("Rua *", controller: streetController,
                      validator: Validatorless.required("Campo obrigatório")),
                  _buildTextField("Número *", controller: numberController,
                      validator: Validatorless.required("Campo obrigatório")),
                  _buildTextField("Bairro *", controller: neighborhoodController,
                      validator: Validatorless.required("Campo obrigatório")),
                  _buildTextField("Estado *", controller: stateController,
                      validator: Validatorless.required("Campo obrigatório")),
                  const SizedBox(height: 12),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) return;

          final family = '';

          // final ok = await familyVm.create(family);

          // if (ok) {
          //   // ref.invalidate(familyViewModelProvider);
          //   if (!mounted) return;

          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Row(
          //         children: [
          //           Icon(Icons.check_circle, color: Colors.white),
          //           SizedBox(width: 12),
          //           Text("Família cadastrada com sucesso!"),
          //         ],
          //       ),
          //       backgroundColor: Colors.green,
          //       behavior: SnackBarBehavior.floating,
          //     ),
          //   );

          //   await Future.delayed(const Duration(milliseconds: 700));
          //   if (!mounted) return;
          //   context.go('/family');
          // }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  // Reutilizável com validações
  Widget _buildTextField(String label,
      {required TextEditingController controller,
      String? Function(String?)? validator,
      void Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildCardHeader() => CardHeader(
        title: 'Nova Família',
        subtitle: 'Cadastro completo para recebimento de cestas básicas',
        colors: const [Color(0xFF2B7FFF), Color(0xFF155DFC)],
        icon: FontAwesomeIcons.heart,
      );

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}
