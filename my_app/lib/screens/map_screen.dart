import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/floating_info_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    final center = prov.userLocation ?? const LatLng(3.1390, 101.6869);

    // Bus stop markers
    final busStopMarkers = prov.busStops.map((s) {
      return Marker(
        point: LatLng(s.lat, s.lng),
        width: 36,
        height: 36,
        child: IconButton(
          icon: const Icon(Icons.location_on, color: Colors.red),
          onPressed: () async {
           // final currentContext = ctx; 
            final etas = await prov.computeEtas(s);
            if (!mounted) return;
            final safeContext = context;
            showModalBottomSheet(
              context: safeContext,
              builder: (_) => Padding(
                padding: const EdgeInsets.all(12),
                child: FloatingInfoCard(
                  title: s.name,
                  line1: 'Next bus: ${etas['bus']} min',
                  line2:
                      'Walk: ${etas['walking']} min • Wait: ${etas['waiting']} min',
                  onAction: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        ),
      );
    }).toList();

    // User location marker
    final userMarker = prov.userLocation != null
        ? Marker(
            point: prov.userLocation!,
            width: 30,
            height: 30,
            child: const Icon(Icons.my_location, color: Colors.blue),
          )
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: center,
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              ...busStopMarkers,
              if (userMarker != null) userMarker,
            ],
          ),
        ],
      ),
    );
  }
}
