import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
//import '../widgets/bus_card.dart';
import '../models/bus_stop.dart';

class BusListScreen extends StatelessWidget {
  const BusListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Bus Stops')),
      body: ListView.builder(
        itemCount: prov.busStops.length,
        itemBuilder: (context, idx) {
          final stop = prov.busStops[idx];
          return BusCard(
            stop: stop,
            onTap: () async {
              final etas = await prov.computeEtas(stop);
              if (!context.mounted) return;
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(stop.name),
                  content: Text(
                    'Bus: ${etas['bus']} min\n'
                    'Walk: ${etas['walking']} min\n'
                    'Wait: ${etas['waiting']} min\n'
                    //'Capacity: ${etas['bus_capacity']}\n'
                    'Available Seats: ${etas['available_seats']}'
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
                  ],
                ),
              );
            },
            onFav: () => prov.toggleFavorite(stop.id),
          );
        },
      ),
    );
  }
}
