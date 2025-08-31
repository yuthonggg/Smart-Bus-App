import 'package:flutter/material.dart';

// BusStop model
class BusStop {
  final String id; 
  final String name;
  final double lat;
  final double lng;
  final List<String> routes; // add routes here
  final int busCapacity;   
  final int occupiedSeats;

  BusStop({
    required this.id, 
    required this.name,
    required this.lat,
    required this.lng,
    this.routes = const [], 
    this.busCapacity = 40,  
    this.occupiedSeats = 0,
  });
  
  // Getter for available seats
  int get availableSeats => busCapacity - occupiedSeats;
}


// BusCard widget
class BusCard extends StatelessWidget {
  final BusStop stop;
  final VoidCallback onTap;
  final VoidCallback onFav;

  const BusCard({
    super.key,
    required this.stop,
    required this.onTap,
    required this.onFav,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text(stop.name),
        subtitle: Text(stop.routes.join(', ')),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.place),
              onPressed: onTap,
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: onFav,
            ),
          ],
        ),
      ),
    );
  }
}
