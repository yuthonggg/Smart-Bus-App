import 'package:flutter/material.dart';
import 'package:my_app/models/bus_stop.dart';

class BusCard extends StatelessWidget {
  final BusStop stop;
  final VoidCallback onTap;
  final VoidCallback onFav;
  final VoidCallback onCapacity;

  const BusCard({
    super.key,
    required this.stop,
    required this.onTap,
    required this.onFav,
    required this.onCapacity, // new callback for capacity
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        title: Text(
          stop.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Routes: ${stop.routes.join(', ')}\n"
          "Capacity: ${stop.busCapacity} seats",
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: Icon(
                stop.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: stop.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: onFav,
            ),
            IconButton(
              icon: const Icon(Icons.event_seat), // Capacity icon
              onPressed: onCapacity,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

