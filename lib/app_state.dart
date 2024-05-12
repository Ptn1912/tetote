import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<LatLng> _places = [
    const LatLng(16.1197601, 108.0619202),
    const LatLng(16.1463556, 108.0780073),
    const LatLng(39.00079119999999, -77.4032275),
    const LatLng(18.3420419, 105.8923492)
  ];
  List<LatLng> get places => _places;
  set places(List<LatLng> value) {
    _places = value;
  }

  void addToPlaces(LatLng value) {
    _places.add(value);
  }

  void removeFromPlaces(LatLng value) {
    _places.remove(value);
  }

  void removeAtIndexFromPlaces(int index) {
    _places.removeAt(index);
  }

  void updatePlacesAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    _places[index] = updateFn(_places[index]);
  }

  void insertAtIndexInPlaces(int index, LatLng value) {
    _places.insert(index, value);
  }

  LatLng? _startingPoint = const LatLng(14.058324, 108.277199);
  LatLng? get startingPoint => _startingPoint;
  set startingPoint(LatLng? value) {
    _startingPoint = value;
  }
}
