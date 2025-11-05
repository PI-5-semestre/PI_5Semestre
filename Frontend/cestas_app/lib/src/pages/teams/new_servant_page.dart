import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';

class NewServantPage extends StatefulWidget {
  const NewServantPage({super.key});

  @override
  State<NewServantPage> createState() => _NewServantPageState();
}

class _NewServantPageState extends State<NewServantPage> {

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
