import 'package:cesta_web/src/widgets/screen_size_widget.dart';
import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/family/providers/family_provider.dart';
import 'package:core/features/shared_preferences/service/storage_service.dart';
import 'package:core/features/viacep/providers/cep_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final cityController = TextEditingController();
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
    cityController.dispose();
    neighborhoodController.dispose();
    stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cepState = ref.watch(viaCepProvider);
    final state = ref.watch(familyControllerProvider);
    final controller = ref.read(familyControllerProvider.notifier);

    cepState.when(
      data: (cep) {
        if (cep != null) {
          streetController.text = cep.logradouro;
          neighborhoodController.text = cep.bairro;
          stateController.text = cep.uf;
          cityController.text = cep.localidade;
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    return Scaffold(
      appBar: AppBar(),
      body: ScreenSizeWidget(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
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
                        Validatorless.regex(RegExp(r'^\d+$'), "Apenas números, 11 dígitos"),
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
                    _buildTextField("Cidade *", controller: cityController,
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
      ),

      floatingActionButton: FloatingActionButton(
        child: state.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.check),
        onPressed: state.isLoading
                ? null
                : () async {
                    final institution_id = await ref.read(storageServiceProvider.notifier).get<String>('institution_id');
                    if (_formKey.currentState!.validate()) {
                      final family = FamilyModel(
                        name: nameController.text.trim(),
                        cpf: cpfController.text.trim(),
                        mobile_phone: phoneController.text.trim(),
                        zip_code: cepController.text.trim(),
                        street: streetController.text.trim(),
                        number: numberController.text.trim(),
                        city: cityController.text.trim(),
                        neighborhood: neighborhoodController.text.trim(),
                        state: stateController.text.trim(),
                        income: "0",
                        institution_id: int.tryParse(institution_id ?? '') ?? 0
                      );

                      await controller.createFamily(family);

                      if (ref.read(familyControllerProvider).error == null) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Família criada com sucesso!",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: theme.colorScheme.primary,
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                      } else {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                ref.read(familyControllerProvider).error!,
                                style: TextStyle(color: theme.colorScheme.onError),
                              ),
                              backgroundColor: theme.colorScheme.error,
                            ),
                          );
                        }
                      }
                    }
                },
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
