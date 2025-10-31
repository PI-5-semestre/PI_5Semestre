import 'package:flutter/material.dart';

class CompletarVisitaModal extends StatelessWidget {
  final String nome;
  final String endereco;

  const CompletarVisitaModal({
    super.key,
    required this.nome,
    required this.endereco,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController dataHoraController = TextEditingController();
    final theme = Theme.of(context);
    String? responsavelSelecionado;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 430,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título + botão fechar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Completar Visita",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
        
              const SizedBox(height: 12),
        
              // Nome e endereço
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(endereco),
                  ],
                ),
              ),
        
              const SizedBox(height: 16),
        
              // Dropdown responsável
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Resultado da Visita",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "aprovado", child: Text("Aprovado")),
                  DropdownMenuItem(value: "reprovado", child: Text("Reprovado")),
                  DropdownMenuItem(value: "revisita", child: Text("Revisita")),
                ],
                onChanged: (value) {
                  responsavelSelecionado = value;
                },
              ),
        
              const SizedBox(height: 16),
        
              // Campo Data e Hora
              _buildTextField("Observações", maxLines: 3),
        
              const SizedBox(height: 20),
        
              // Botões
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // ação de salvar
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: const Text("Completar Visita"),
                  ),
                ],
              )
            ],
          ),
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
