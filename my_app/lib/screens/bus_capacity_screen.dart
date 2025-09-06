import 'package:flutter/material.dart';
import 'package:my_app/models/bus_stop.dart';
import 'package:my_app/widgets/bus_capacity.dart';

class BusCapacityScreen extends StatelessWidget {
  final BusStop stop;

  const BusCapacityScreen({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bus Capacity - ${stop.name}")),
      body:  Padding(
        padding: EdgeInsets.all(16),
        child: BusCapacityLayout(), // your layout widget
      ),
    );
  }
}
