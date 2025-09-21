import 'package:core/widgets/card_header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewFamilyPage extends StatefulWidget {
  const NewFamilyPage({super.key});

  @override
  State<NewFamilyPage> createState() => _NewFamilyPageState();
}

class _NewFamilyPageState extends State<NewFamilyPage> {
  final TextEditingController familySizeController = TextEditingController();
  final TextEditingController comprovanteController = TextEditingController();

  int familySize = 0;

  List<Map<String, dynamic>> familyMembers = [];

  // Pessoas autorizadas (máx 2)
  List<Map<String, dynamic>> authorizedPeople = [];

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
            "relationship": "Filho(a)",
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
          "relationship": "Filho(a)",
          "otherController": TextEditingController(),
        });
      });
    }
  }

  Future<void> _pickComprovante() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        comprovanteController.text =
            result.files.single.name; // salva no controller
      });
    }
  }

  @override
  void dispose() {
    familySizeController.dispose();
    for (var member in familyMembers) {
      member.values.forEach((controller) => controller.dispose());
    }
    for (var person in authorizedPeople) {
      (person["name"] as TextEditingController).dispose();
      (person["cpf"] as TextEditingController).dispose();
      (person["otherController"] as TextEditingController).dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 800,
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [_buildCardHeader()],
                    ),
                    _buildSection(
                      title: "Informações Pessoais",
                      icon: Icons.person,
                      children: [
                        _buildTextField("Nome do Responsável *"),
                        _buildTextField("CPF *"),
                        _buildTextField("Telefone"),
                        _buildTextField(
                          "Tamanho da Família",
                          controller: familySizeController,
                          onChanged: _updateFamilySize,
                        ),
                      ],
                    ),

                    // membros da família
                    if (familySize > 0)
                      _buildSection(
                        title: "Membros da Família",
                        icon: Icons.group,
                        children: familyMembers.asMap().entries.map((entry) {
                          int index = entry.key;
                          var member = entry.value;
                          return Card(
                            color: Colors.white,
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Membro ${index + 1}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  _buildTextField(
                                    "Nome",
                                    controller: member["name"],
                                  ),
                                  _buildTextField(
                                    "CPF",
                                    controller: member["cpf"],
                                  ),
                                  DropdownButtonFormField<String>(
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Filho(a)",
                                        child: Text("Filho(a)"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Cônjuge",
                                        child: Text("Cônjuge"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Pai/Mãe",
                                        child: Text("Pai/Mãe"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Irmão/Irmã",
                                        child: Text("Irmão/Irmã"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Outro",
                                        child: Text("Outro"),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        member["relationship"] = value!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: "Grau de Parentesco",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  if (member["relationship"] == "Outro") ...[
                                    const SizedBox(height: 6),
                                    _buildTextField(
                                      "Informe o grau",
                                      controller: member["otherController"],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    _buildSection(
                      title: "Endereço",
                      icon: Icons.location_on,
                      children: [
                        _buildTextField("CEP"),
                        _buildTextField("Rua *"),
                        _buildTextField("Número *"),
                        _buildTextField("Bairro *"),
                        _buildTextField("Estado *"),

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

                    // pessoas autorizadas
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
                            color: Colors.white,
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Pessoa Autorizada ${index + 1}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            authorizedPeople.removeAt(index);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  _buildTextField(
                                    "Nome",
                                    controller: person["name"],
                                  ),
                                  _buildTextField(
                                    "CPF",
                                    controller: person["cpf"],
                                  ),
                                  DropdownButtonFormField<String>(
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Filho(a)",
                                        child: Text("Filho(a)"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Cônjuge",
                                        child: Text("Cônjuge"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Pai/Mãe",
                                        child: Text("Pai/Mãe"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Irmão/Irmã",
                                        child: Text("Irmão/Irmã"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Outro",
                                        child: Text("Outro"),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        person["relationship"] = value!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: "Grau de Parentesco",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  if (person["relationship"] == "Outro") ...[
                                    const SizedBox(height: 6),
                                    _buildTextField(
                                      "Informe o grau",
                                      controller: person["otherController"],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }),
                        if (authorizedPeople.length < 2)
                          ElevatedButton.icon(
                            onPressed: _addAuthorizedPerson,
                            icon: const Icon(Icons.add),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  Colors.deepPurple, // ícone e texto
                            ),
                            label: const Text(
                              "Adicionar Pessoa",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    _buildSection(
                      title: "Informações Socioeconômicas",
                      icon: Icons.info,
                      children: [
                        _buildTextField("Renda Mensal (R\$)"),
                        DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem(
                              value: "Pendente",
                              child: Text("Pendente"),
                            ),
                            DropdownMenuItem(
                              value: "Aprovado",
                              child: Text("Aprovado"),
                            ),
                            DropdownMenuItem(
                              value: "Reprovado",
                              child: Text("Reprovado"),
                            ),
                          ],
                          onChanged: (v) {},
                          decoration: InputDecoration(
                            labelText: "Situação",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                        ),

                        _buildTextField("Observações", maxLines: 3),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/family",
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: const Text("Cancelar"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF155DFC),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: const Text(
                              "Cadastrar Família",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
      color: Colors.white,
      elevation: 3,
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
}
