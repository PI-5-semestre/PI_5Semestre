import 'package:flutter/material.dart';

class AgendarVisitaModal extends StatelessWidget {
  final String nome;
  final String endereco;

  const AgendarVisitaModal({
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
                    "Agendar Visita",
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
        
              // Campo Data e Hora
              TextField(
                controller: dataHoraController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Data e Hora",
                  hintText: "dd/mm/aaaa, --:--",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
        
                  if (date != null) {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
        
                    if (time != null) {
                      final dt = DateTime(
                          date.year, date.month, date.day, time.hour, time.minute);
                      dataHoraController.text =
                          "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}, ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                    }
                  }
                },
              ),
        
              const SizedBox(height: 16),
        
              // Dropdown responsável
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Responsável",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "Maria", child: Text("Maria")),
                  DropdownMenuItem(value: "João", child: Text("João")),
                  DropdownMenuItem(value: "Ana", child: Text("Ana")),
                ],
                onChanged: (value) {
                  responsavelSelecionado = value;
                },
              ),
        
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
                    child: const Text("Agendar Visita"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
