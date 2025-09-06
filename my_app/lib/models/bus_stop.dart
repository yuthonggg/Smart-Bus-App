//import 'package:flutter/material.dart';

// BusStop model
class BusStop {
  final String id; 
  final String name;
  final double lat;
  final double lng;
  final List<String> routes; // add routes here
  final int busCapacity;   
  final int occupiedSeats;
  bool isFavorite;

  BusStop({
    required this.id, 
    required this.name,
    required this.lat,
    required this.lng,
    this.routes = const [], 
    this.busCapacity = 40,  
    this.occupiedSeats = 0,
    this.isFavorite = false,
  });
  
  // Getter for available seats
  int get availableSeats => busCapacity - occupiedSeats;
}