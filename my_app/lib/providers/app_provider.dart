import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
import '../models/bus_stop.dart';
import '../services/eta_service.dart';

class AppProvider extends ChangeNotifier {
  final Location _location = Location();
  LatLng? userLocation;
  List<BusStop> busStops = [];
  Set<String> favorites = {};
  bool loadingLocation = false;
  
  

  AppProvider();

  Future<void> init() async {
    // request location permission and get location
    await _requestLocation();
    _loadDummyStops();
    notifyListeners();
  }

  Future<void> _requestLocation() async {
    loadingLocation = true;
    notifyListeners();

    try {
      final hasPerm = await _location.requestPermission();
      if (hasPerm == PermissionStatus.granted ||
          hasPerm == PermissionStatus.grantedLimited) {
        final u = await _location.getLocation();
        userLocation = LatLng(u.latitude ?? 0.0, u.longitude ?? 0.0);
      }
    } catch (e) {
      // ignore
    } finally {
      loadingLocation = false;
      notifyListeners();
    }
  }

  void _loadDummyStops() {
    // some sample bus stops around KL (you can replace)
    const idGen =  Uuid();
    busStops = [
      BusStop(
          id: idGen.v4(),
          name: 'UM Central',
          lat: 3.1390,
          lng: 101.6869,
          routes: ['T1', 'B12'],
          busCapacity: 40,
          occupiedSeats: 25,
          ),
          

      BusStop(
          id: idGen.v4(),
          name: 'Kolej Kediaman 1',
          lat: 3.1478,
          lng: 101.7123,
          routes: ['B5', 'M2'],
          busCapacity: 40,
          occupiedSeats: 25,
          ),
          

      BusStop(
          id: idGen.v4(),
          name: 'Pusat Sukan',
          lat: 3.1579,
          lng: 101.7123,
          routes: ['E1', 'C7'],
          busCapacity: 40,
          occupiedSeats: 25,
          ),
          
    ];
  }

  void toggleFavorite(String stopId) {
    if (favorites.contains(stopId)) {
      favorites.remove(stopId);
    } else {
      favorites.add(stopId);
    }
    notifyListeners();
  }

  

  Future<Map<String, dynamic>> computeEtas(BusStop stop) async {
    // Use eta_service for dummy or real logic
    final walking = EtaService.estimateWalking(userLocation, LatLng(stop.lat, stop.lng));
    final busEta = await EtaService.estimateBusEta(stop); // async maybe call API later
    return {
      'walking': walking,
      'bus': busEta,
      'waiting': (busEta - walking).abs(), // dummy
      'bus_capacity': stop.busCapacity,
      'occupied_seats': stop.occupiedSeats,
      'available_seats': stop.availableSeats,

    };
  }
}
