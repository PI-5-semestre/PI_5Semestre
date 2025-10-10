import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Supondo que você tenha o CardHeader implementado corretamente
// Se não tiver, posso te ajudar a criá-lo também

class FamilyBasketEditor extends StatefulWidget {
  final String familyName;
  final Map<String, TextEditingController> itemControllers;
  final VoidCallback onSave;

  const FamilyBasketEditor({
    super.key,
    required this.familyName,
    required this.itemControllers,
    required this.onSave,
  });

  @override
  State<FamilyBasketEditor> createState() => _FamilyBasketEditorState();
}

class _FamilyBasketEditorState extends State<FamilyBasketEditor> {
  final List<String> defaultItems = [
    'Arroz',
    'Feijão',
    'Leite',
    'Óleo',
    'Farinha',
    'Macarrão',
  ];

  @override
  void initState() {
    super.initState();
    for (var item in defaultItems) {
      widget.itemControllers.putIfAbsent(item, () => TextEditingController(text: '1'));
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Não limpamos os controllers aqui, pois são gerenciados fora
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
            const SizedBox(height: 16),
            Text(
              "Cesta para ${widget.familyName}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...defaultItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(item),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: widget.itemControllers[item],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Qtd',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: widget.onSave,
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Salvar Cesta',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF155DFC),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Edição Cesta',
      subtitle: 'Faça edição de itens da cesta',
      colors: [const Color(0xFF2B7FFF), const Color(0xFF155DFC)],
      icon: FontAwesomeIcons.heart,
    );
  }
}
