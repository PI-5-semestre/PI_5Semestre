import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/family/providers/family_provider.dart';
import 'package:core/features/viacep/providers/cep_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

class EditFamilyPage extends ConsumerStatefulWidget {
  final FamilyModel family;
  const EditFamilyPage({super.key, required this.family});

  @override
  ConsumerState<EditFamilyPage> createState() => _EditFamilyPageState();
}

class _EditFamilyPageState extends ConsumerState<EditFamilyPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneController = TextEditingController();

  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  final incomeController = TextEditingController();
  final descriptionController = TextEditingController();
  final situationController = TextEditingController();
  final familySizeController = TextEditingController();
  final comprovanteController = TextEditingController();

  int familySize = 0;
  List<Map<String, dynamic>> familyMembers = [];
  List<Map<String, dynamic>> authorizedPeople = [];

  Future<void> _searchCep(String cep) async {
    if (cep.length == 8) {
      await ref.read(viaCepProvider.notifier).fetchCep(cep);
      final data = ref.read(viaCepProvider);
      data.whenOrNull(data: (cep) {
        streetController.text = cep?.logradouro ?? '';
        neighborhoodController.text = cep?.bairro ?? '';
        stateController.text = cep?.uf ?? '';
      });
    }
  }

  void _updateFamilySize(String value) {
    int size = int.tryParse(value) ?? 0;
    if (size != familySize) {
      setState(() {
        familySize = size;
        familyMembers = List.generate(
          familySize,
          (_) => {
            "name": TextEditingController(),
            "cpf": TextEditingController(),
            "kinship": "SON",
            "otherController": TextEditingController(),
          },
        );
      });
    }
  }

  void _addAuthorizedPerson() {
    if (authorizedPeople.length < 2) {
      setState(() {
        authorizedPeople.add({
          "name": TextEditingController(),
          "cpf": TextEditingController(),
          "kinship": "SON",
          "otherController": TextEditingController(),
        });
      });
    }
  }

  String? selectedFilePath;

  Future<void> _pickComprovante() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFilePath = result.files.single.path!;
        comprovanteController.text = result.files.single.name;
      });
    }
  }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(familyControllerProvider.notifier).fetchFamilies();
    });

    final f = widget.family;

    nameController.text = f.name;
    cpfController.text = f.cpf;
    phoneController.text = f.mobile_phone;
    cepController.text = f.zip_code;
    streetController.text = f.street;
    numberController.text = f.number;
    neighborhoodController.text = f.neighborhood;
    stateController.text = f.state;
    incomeController.text = f.income ?? '';
    descriptionController.text = f.description ?? '';
    situationController.text = f.situation ?? '';
    cityController.text = f.city ?? '';

    if (f.members != null && f.members!.isNotEmpty) {
      familySize = f.members!.length;
      familySizeController.text = familySize.toString();

      familyMembers = f.members!.map((m) => {
        "name": TextEditingController(text: m.name),
        "cpf": TextEditingController(text: m.cpf),
        "kinship": m.kinship,
        "otherController": TextEditingController(
          text: m.kinship == "OTHER" ? m.kinship : '',
        ),
      }).toList();
    }
  }

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
    incomeController.dispose();
    descriptionController.dispose();
    comprovanteController.dispose();
    situationController.dispose();
    cityController.dispose();
    familySizeController.dispose();
    for (var member in familyMembers) {
      member["name"].dispose();
      member["cpf"].dispose();
      member["otherController"].dispose();
    }
    for (var person in authorizedPeople) {
      person["name"].dispose();
      person["cpf"].dispose();
      person["otherController"].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(familyControllerProvider.notifier);
    final state = ref.watch(familyControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              _buildCardHeader(),

              _buildSection(
                title: "Informações Pessoais",
                icon: Icons.person,
                children: [
                  _buildTextField("Nome *",
                    controller: nameController,
                    validator: Validatorless.required("Campo obrigatório"),
                  ),
                  _buildTextField("CPF *",
                    controller: cpfController,
                    readOnly: true,
                  ),
                  _buildTextField("Telefone", controller: phoneController),
                  _buildTextField(
                    "Tamanho da Família",
                    controller: familySizeController,
                    onChanged: _updateFamilySize,
                    validator: Validatorless.number("Informe um número válido"),
                  ),
                ],
              ),

              if (familySize > 0)
                _buildSection(
                  title: "Membros da Família",
                  icon: Icons.group,
                  children: familyMembers.asMap().entries.map((entry) {
                    int index = entry.key;
                    var member = entry.value;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Membro ${index + 1}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField("Nome *",
                              controller: member["name"],
                              validator: Validatorless.required("Campo obrigatório"),
                            ),
                            _buildTextField("CPF",
                              controller: member["cpf"],
                            ),
                            DropdownButtonFormField<String>(
                              initialValue: member["kinship"] ?? "SON",
                              items: const [
                                DropdownMenuItem(value: "SON", child: Text("Filho(a)")),
                                DropdownMenuItem(value: "SPOUSE", child: Text("Cônjuge")),
                                DropdownMenuItem(value: "FATHER", child: Text("Pai")),
                                DropdownMenuItem(value: "MOTHER", child: Text("Mãe")),
                                DropdownMenuItem(value: "OTHER", child: Text("Outro")),
                              ],
                              onChanged: (value) {
                                setState(() => member["kinship"] = value!);
                              },
                              decoration: const InputDecoration(
                                labelText: "Grau de Parentesco",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            if (member["kinship"] == "OTHER") ...[
                              const SizedBox(height: 6),
                              _buildTextField("Informe o grau *",
                                controller: member["otherController"],
                                validator: Validatorless.required("Campo obrigatório"),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

              _buildSection(
                title: "Pessoas Autorizadas",
                icon: Icons.group_add,
                children: [
                  const Text("Cadastre até 2 pessoas autorizadas"),
                  const SizedBox(height: 8),

                  ...authorizedPeople.asMap().entries.map((entry) {
                    int index = entry.key;
                    var person = entry.value;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Pessoa Autorizada ${index + 1}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    setState(() => authorizedPeople.removeAt(index));
                                  },
                                ),
                              ],
                            ),
                            _buildTextField("Nome *",
                              controller: person["name"],
                              validator: Validatorless.required("Informe o nome"),
                            ),
                            _buildTextField("CPF", controller: person["cpf"]),
                            DropdownButtonFormField<String>(
                              initialValue: person["kinship"] ?? "SON",
                              items: const [
                                DropdownMenuItem(value: "SON", child: Text("Filho(a)")),
                                DropdownMenuItem(value: "SPOUSE", child: Text("Cônjuge")),
                                DropdownMenuItem(value: "FATHER", child: Text("Pai")),
                                DropdownMenuItem(value: "MOTHER", child: Text("Mãe")),
                                DropdownMenuItem(value: "OTHER", child: Text("Outro")),
                              ],
                              onChanged: (value) {
                                setState(() => person["kinship"] = value!);
                              },
                              decoration: const InputDecoration(
                                labelText: "Grau de Parentesco",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            if (person["kinship"] == "OTHER") ...[
                              const SizedBox(height: 6),
                              _buildTextField("Informe o grau *",
                                controller: person["otherController"],
                                validator: Validatorless.required("Campo obrigatório"),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),

                  if (authorizedPeople.length < 2)
                    OutlinedButton.icon(
                      onPressed: _addAuthorizedPerson,
                      icon: const Icon(Icons.add),
                      label: const Text("Adicionar Pessoa",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                ],
              ),

              _buildSection(
                title: "Endereço",
                icon: Icons.location_on,
                children: [
                  _buildTextField("CEP *",
                    controller: cepController,
                    validator: Validatorless.required("Campo obrigatório"),
                    onChanged: _searchCep,
                  ),
                  _buildTextField("Rua *",
                    controller: streetController,
                    validator: Validatorless.required("Campo obrigatório"),
                  ),
                  _buildTextField("Número *",
                    controller: numberController,
                    validator: Validatorless.required("Campo obrigatório"),
                  ),
                  _buildTextField("Bairro *",
                    controller: neighborhoodController,
                    validator: Validatorless.required("Campo obrigatório"),
                  ),
                  _buildTextField("Cidade *",
                    controller: cityController,
                    validator: Validatorless.required("Campo obrigatório"),
                  ),
                  _buildTextField("Estado *",
                    controller: stateController,
                    validator: Validatorless.required("Campo obrigatório"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: comprovanteController,
                    readOnly: true,
                    onTap: _pickComprovante,
                    decoration: InputDecoration(
                      labelText: "Comprovante (Arquivo)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: const Icon(Icons.upload_file),
                    ),
                  ),
                ],
              ),

              _buildSection(
                title: "Informações Socioeconômicas",
                icon: Icons.info,
                children: [
                  _buildTextField("Renda Mensal (R\$)", controller: incomeController),
                  DropdownButtonFormField<String>(
                    value: situationController.text.isNotEmpty
                        ? situationController.text
                        : widget.family.situation,
                    items: const [
                      DropdownMenuItem(value: "PENDING", child: Text("Pendente")),
                      DropdownMenuItem(value: "ACTIVE", child: Text("Aprovado")),
                      DropdownMenuItem(value: "SUSPENDED", child: Text("Suspenso")),
                    ],
                    onChanged: (v) => situationController.text = v ?? '',
                    validator: Validatorless.required("Selecione uma opção"),
                    decoration: InputDecoration(
                      labelText: "Situação",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  _buildTextField("Observações",
                    controller: descriptionController,
                    maxLines: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: state.isLoading ? null : () async {
          if (!formKey.currentState!.validate()) return;

          if (authorizedPeople.length > 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Máximo de 2 pessoas autorizadas")),
            );
            return;
          }

          final updated = widget.family.copyWith(
            name: nameController.text.trim(),
            cpf: cpfController.text.trim(),
            mobile_phone: phoneController.text.trim(),

            zip_code: cepController.text.trim(),
            street: streetController.text.trim(),
            number: numberController.text.trim(),
            neighborhood: neighborhoodController.text.trim(),
            city: cityController.text.trim(),
            state: stateController.text.trim(),

            income: incomeController.text.trim(),
            situation: situationController.text.trim(),
            description: descriptionController.text.trim(),
            members: familyMembers.map((member) {
              final kinshipValue = member["kinship"]?.toString() ?? "SON";
              final finalKinship = kinshipValue == "OTHER"
                  ? member["otherController"]?.text.trim() ?? kinshipValue
                  : kinshipValue;

              return Member(
                name: member["name"]?.text.trim() ?? "",
                cpf: member["cpf"]?.text.trim() ?? "",
                kinship: finalKinship,
                family_id: widget.family.id,
              );
            }).toList(),
          );

          await vm.updateFamily(updated);

          if (ref.read(familyControllerProvider).error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ref.read(familyControllerProvider).error!)),
            );
            return;
          }

          if (selectedFilePath != null) {
            final ext = selectedFilePath!.split('.').last.toLowerCase();
            await vm.uploadDocument(
              cpf: widget.family.cpf,
              docType: ext,
              filePath: selectedFilePath!,
            );

            if (ref.read(familyControllerProvider).error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(ref.read(familyControllerProvider).error!)),
              );
              return;
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Família atualizada com sucesso!")),
          );
          if (mounted) context.pop();
        },
        child: state.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.check),
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Editar Família',
      subtitle: 'Atualize os dados da família',
      colors: const [Color(0xFF2B7FFF), Color(0xFF155DFC)],
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
                Text(title, style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
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
    String? Function(String?)? validator,
    bool readOnly = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
