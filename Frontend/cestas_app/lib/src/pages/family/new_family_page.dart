import 'package:core/features/family/domain/family_view_model.dart';
import 'package:core/models/Family/family_model.dart';
import 'package:core/features/family/domain/new_family_view_model.dart';
import 'package:core/widgets/card_header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NewFamilyPage extends ConsumerStatefulWidget {
  const NewFamilyPage({super.key});

  @override
  ConsumerState<NewFamilyPage> createState() => _NewFamilyPageState();
}

class _NewFamilyPageState extends ConsumerState<NewFamilyPage> {
  final TextEditingController comprovanteController = TextEditingController();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneController = TextEditingController();

  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final stateController = TextEditingController();

  final estados = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
  ];

  String? selectedEstado;

  Future<void> _pickComprovante() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        comprovanteController.text = result.files.single.name;
      });
    }
  }

  @override
  void dispose() {
    comprovanteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var familyVm = ref.watch(newFamilyViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                ),
                _buildTextField("CPF *", controller: cpfController),
                _buildTextField("Telefone", controller: phoneController),
              ],
            ),

            // membros da família
            _buildSection(
              title: "Endereço",
              icon: Icons.location_on,
              children: [
                _buildTextField("CEP", controller: cepController),
                _buildTextField("Rua *", controller: streetController),
                _buildTextField("Número *", controller: numberController),
                _buildTextField("Bairro *", controller: neighborhoodController),
                // _buildTextField("Estado *", controller: stateController),
                _buildEstadoDropdown(),

                const SizedBox(height: 12),
                TextFormField(
                  controller: comprovanteController,
                  readOnly: true,
                  onTap:
                      _pickComprovante, // <-- agora o campo todo abre o seletor
                  decoration: InputDecoration(
                    labelText: "Comprovante de Endereço *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: const Icon(
                      Icons.upload_file,
                    ), // ícone fica só visual
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var family = FamilyModel(
            name: nameController.text,
            cpf: cpfController.text,
            mobile_phone: phoneController.text,
            zip_code: cepController.text,
            street: streetController.text,
            number: numberController.text,
            neighborhood: neighborhoodController.text,
            state: stateController.text,
            situation: "pendente",
            income: "0",
            description: "",
            institution_id: 1,
          );

          final ok = await familyVm.create(family);

          if (ok) {

            ref.invalidate(familyViewModelProvider);

            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 12),
                    Text("Família cadastrada com sucesso!"),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );

            await Future.delayed(const Duration(milliseconds: 700));

            if (!mounted) return;

            context.go('/family');
          }
        },

        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Nova Família',
      subtitle: 'Cadastro completo para recebimento de cestas básicas',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: FontAwesomeIcons.heart,
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
    TextEditingController? controller,
    Function(String)? onChanged,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildEstadoDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        items: estados.map((e) {
          return DropdownMenuItem(value: e, child: Text(e));
        }).toList(),
        onChanged: (value) {
          stateController.text = value ?? '';
        },
        value: stateController.text.isEmpty ? null : stateController.text,
        decoration: InputDecoration(
          labelText: "Estado *",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
