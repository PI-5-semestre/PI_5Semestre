import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4FACFE), Color.fromARGB(255, 1, 172, 181)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.person_rounded,
                        color: Color(0xFF4FACFE),
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gabriel Souza',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'gabriel@email.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _ProfileStat(value: '152', label: 'Famílias'),
                    _ProfileStat(value: '24', label: 'Cestas'),
                    _ProfileStat(value: '8', label: 'Voluntários'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Opções',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E2A46),
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),
          _OptionTile(
            color: const Color(0xFF64B5F6),
            icon: FontAwesomeIcons.boxesStacked,
            title: 'Gerenciar Cestas',
            onTap: () => Navigator.pushNamed(context, '/basket'),
          ),
          _OptionTile(
            color: const Color(0xFF4FC3F7),
            icon: FontAwesomeIcons.peopleGroup,
            title: 'Visitas',
            onTap: () => Navigator.pushNamed(context, '/visits'),
          ),
          _OptionTile(
            color: const Color(0xFF9575CD),
            icon: FontAwesomeIcons.boxArchive,
            title: 'Gerenciar o estoque',
            onTap: () => Navigator.pushNamed(context, '/stock'),
          ),
          _OptionTile(
            color: const Color(0xFF81C784),
            icon: FontAwesomeIcons.userShield,
            title: 'Configurações',
            onTap: () => Navigator.pushNamed(context, '/config'),
          ),
          _OptionTile(
            color: const Color(0xFFE57373),
            icon: FontAwesomeIcons.rightFromBracket,
            title: 'Sair da Conta',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Cesta do Amor v1.0.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _OptionTile({
    required this.color,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            color: Color(0xFF1E2A46),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
