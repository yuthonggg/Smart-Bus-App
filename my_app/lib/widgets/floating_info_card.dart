import 'package:flutter/material.dart';

class FloatingInfoCard extends StatelessWidget {
  final String title;
  final String line1;
  final String line2;
  final VoidCallback onAction;

  const FloatingInfoCard({
    super.key,
    required this.title,
    required this.line1,
    required this.line2,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Text(line1),
          Text(line2),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: onAction, child: const Text('Refresh')),
        ],
      ),
    );
  }
}
