// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:convert';

// Hàm để tìm kiếm địa điểm
Future<List<dynamic>> getPlaces(String searchQuery, String accessToken) async {
  String encodedQuery = Uri.encodeFull(searchQuery);
  final response = await http.get(
      Uri.parse(
          'https://api.mapbox.com/geocoding/v5/mapbox.places/$encodedQuery.json?&access_token=$accessToken'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> features = jsonResponse['features'];
    if (features.isEmpty) {
      return [
        {'place_name': 'No places found'}
      ];
    } else {
      return features;
    }
  } else {
    return [
      {'place_name': 'No places found'}
    ];
  }
}

// Trong hàm của bạn để xử lý kết quả tìm kiếm
void handleSearchResult(List<dynamic> searchResults, dynamic mapWidget) {
  if (searchResults.isNotEmpty) {
    // Lấy tọa độ của địa điểm đầu tiên
    var coordinates = searchResults[0]['geometry']['coordinates'];
    // Di chuyển bản đồ đến vị trí được tìm kiếm
    mapWidget.centerOnPoint(coordinates[1], coordinates[0]);
  } else {
    // Nếu không có kết quả tìm kiếm, reset bản đồ
    // Đặt lại tọa độ trung tâm và phóng to mức zoom ban đầu
    var initialLatitude;
    var initialLongitude;
    mapWidget.centerOnPoint(initialLatitude, initialLongitude);
    var initialZoom;
    mapWidget.setZoom(initialZoom);
  }
}
