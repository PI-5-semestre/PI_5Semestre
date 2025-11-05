import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditServantPage extends StatefulWidget {
  const EditServantPage({super.key});

  @override
  State<EditServantPage> createState() => _EditServantPageState();
}

class _EditServantPageState extends State<EditServantPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: ListView(
          children: [
            _buildCardHeader(),

            _buildSection(
              title: "Informações de Acesso",
              icon: Icons.login,
              children: [
                _buildTextField("E-mail *"),
                _buildTextField("Senha *"),
                _buildTextField("Confirme sua senha *"),
              ],
            ),

            _buildSection(
              title: "Informações Pessoais",
              icon: Icons.person,
              children: [
                _buildTextField("Nome *"),
                _buildTextField("CPF *"),
                _buildTextField("Telefone *"),
              ],
            ),

            _buildSection(
              title: "Tipo de Atividade",
              icon: Icons.info,
              children: [
                DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem(
                      value: "coordenador",
                      child: Text("Coordenador"),
                    ),
                    DropdownMenuItem(
                      value: "entregador",
                      child: Text("Entregador"),
                    ),
                    DropdownMenuItem(
                      value: "assistente_social",
                      child: Text("Assistente Social"),
                    ),
                    DropdownMenuItem(
                      value: "voluntario",
                      child: Text("Voluntário"),
                    ),
                  ],
                  onChanged: (v) {},
                  decoration: InputDecoration(
                    labelText: "Atividade",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Editar Funcionário',
      subtitle: 'Atualizar informações de funcionários',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
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
