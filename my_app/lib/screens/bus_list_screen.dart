import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/providers/app_provider.dart';
import 'package:my_app/widgets/bus_card.dart';
import 'package:my_app/widgets/bus_capacity.dart'; // ✅ import the layout, not screen

class BusListScreen extends StatelessWidget {
  const BusListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return ListView.builder(
      itemCount: prov.busStops.length,
      itemBuilder: (context, idx) {
        final stop = prov.busStops[idx];
        return BusCard(
          stop: stop,
          onTap: () async {
            final etas = await prov.computeEtas(stop);
            if (!context.mounted) return;

            // Show next bus info in bottom sheet
            showModalBottomSheet(
              context: context,
              builder: (_) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stop.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Next Bus: ${etas['bus']} min'),
                    Text('Walk: ${etas['walking']} min'),
                    Text('Wait: ${etas['waiting']} min'),
                    Text('Available Seats: ${etas['available_seats']}'),
                  ],
                ),
              ),
            );
          },
          onFav: () => prov.toggleFavorite(stop.id),
          onCapacity: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Bus Capacity - ${stop.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      BusCapacityLayout(
                        busCapacity: stop.busCapacity,
                        occupiedSeats: stop.occupiedSeats,
                      ),
                    ],
                  ),
                ),
              ),
            ); // ✅ fixed: closed showModalBottomSheet properly
          },
        );
      },
    );
  }
}
