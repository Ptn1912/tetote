import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

LatLng flipCoords(List<String> coordinates) {
  double longitude = double.parse(coordinates[0]);
  double latitude = double.parse(coordinates[1]);
  LatLng latlng = LatLng(latitude, longitude);
  return latlng;
}
