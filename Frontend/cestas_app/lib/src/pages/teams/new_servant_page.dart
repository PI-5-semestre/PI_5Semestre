import 'package:core/widgets/card_header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NewServantPage extends StatefulWidget {
  const NewServantPage({super.key});

  @override
  State<NewServantPage> createState() => _NewServantPageState();
}

class _NewServantPageState extends State<NewServantPage> {
  final TextEditingController comprovanteController = TextEditingController();

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
                _buildTextField("Nome do Responsável *"),
                _buildTextField("CPF *"),
                _buildTextField("Telefone"),
              ],
            ),
            
            // membros da família
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
            const SizedBox(height: 20),
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
      title: 'Novo Funcionário',
      subtitle: 'Cadastro para novos funcionários',
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
