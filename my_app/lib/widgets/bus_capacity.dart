import 'package:flutter/material.dart';

class BusCapacityLayout extends StatelessWidget {
  final int busCapacity;
  final int occupiedSeats;

  const BusCapacityLayout({
    super.key,
    required this.busCapacity,
    required this.occupiedSeats,
  });

  @override
  Widget build(BuildContext context) {
    final seats = List.generate(
      busCapacity,
      (i) => i >= occupiedSeats, // true = available, false = occupied
    );

    return Column(
      children: List.generate(
        (seats.length / 4).ceil(),
        (row) {
          final leftSeats = [
            _buildSeat(seats, row * 4),
            _buildSeat(seats, row * 4 + 1),
          ];
          final rightSeats = [
            _buildSeat(seats, row * 4 + 2),
            _buildSeat(seats, row * 4 + 3),
          ];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...leftSeats,
                const SizedBox(width: 30), // aisle
                ...rightSeats,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeat(List<bool> seats, int index) {
    if (index >= seats.length) {
      return const SizedBox(width: 30);
    }
    final available = seats[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(
        Icons.event_seat,
        color: available ? Colors.green : Colors.red,
        size: 28,
      ),
    );
  }
}
