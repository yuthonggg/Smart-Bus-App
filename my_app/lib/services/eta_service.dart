import 'package:latlong2/latlong.dart';
import 'package:my_app/models/bus_stop.dart';

class EtaService {
  static const Distance _dist = Distance();

  // simple walking estimate in minutes
  static int estimateWalking(LatLng? from, LatLng to) {
    if (from == null) return 999;
    final metres = _dist.as(LengthUnit.Meter, from, to).round();
    // assume walking speed 1.4 m/s ~ 5 km/h -> 12 min per km ~ 0.72 m/s? approximate
    final mins = (metres / 80).round(); // ~80 metres per minute
    return mins.clamp(1, 999);
  }

  // dummy bus ETA - in real app call transit API or GTFS
  static Future<int> estimateBusEta(BusStop stop) async {
    // simulate network / processing
    await Future.delayed(const Duration(milliseconds: 400));
    // produce a pseudo-random ETA based on stop id
    final base = stop.id.hashCode % 10; // 0..9
    final eta = 3 + base; // 3..12 minutes
    return eta;
  }
}
