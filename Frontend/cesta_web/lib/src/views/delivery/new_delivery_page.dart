import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewDeliveryPage extends StatefulWidget {
  const NewDeliveryPage({super.key});

  @override
  State<NewDeliveryPage> createState() => _NewDeliveryPageState();
}

class _NewDeliveryPageState extends State<NewDeliveryPage> {
  String? selectedFamily;
  String? selectedDeliverer;
  DateTime? selectedDate;
  TextEditingController observationsController = TextEditingController();

  final List<String> families = [
    "Família Silva",
    "Família Costa",
    "Família Souza",
  ];
  final List<String> deliverers = ["Fernanda", "Carlos", "João"];

  Future<void> pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            margin: EdgeInsets.only(bottom: 16),
            width: 800,
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CardHeader(
                          title: "Nova Entrega",
                          subtitle:
                              "Agende a entrega de cestas básicas para famílias",
                          colors: [Color(0xFF9810FA), Color(0xFFA223FC)],
                          icon: FontAwesomeIcons.truck,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSection(
                      title: "Informações da Entrega",
                      icon: Icons.info,
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Selecione a família",
                            border: OutlineInputBorder(),
                          ),
                          value: selectedFamily,
                          items: families
                              .map(
                                (f) =>
                                    DropdownMenuItem(value: f, child: Text(f)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => selectedFamily = v),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: pickDate,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: "Selecione a data",
                              border: OutlineInputBorder(),
                            ),
                            child: Text(
                              selectedDate != null
                                  ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                  : "Toque para selecionar",
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Selecione o entregador",
                            border: OutlineInputBorder(),
                          ),
                          value: selectedDeliverer,
                          items: deliverers
                              .map(
                                (d) =>
                                    DropdownMenuItem(value: d, child: Text(d)),
                              )
                              .toList(),
                          onChanged: (v) =>
                              setState(() => selectedDeliverer = v),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: observationsController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: "Observações",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text("Cancelar"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9810FA),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              "Agendar Entrega",
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: ListView(
  //         children: [
  //           CardHeader(
  //             title: "Nova Entrega",
  //             subtitle: "Agende a entrega de cestas básicas para famílias",
  //             colors: [Color(0xFF9810FA), Color(0xFFA223FC)],
  //             icon: FontAwesomeIcons.truck,
  //           ),

  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
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
}
