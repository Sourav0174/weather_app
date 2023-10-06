import 'package:flutter/material.dart';

class AdditionalInformationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInformationItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(
              icon,
              size: 42,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
