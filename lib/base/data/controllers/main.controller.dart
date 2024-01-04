import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:geocoding/geocoding.dart' hide Location;

import 'package:place_picker/place_picker.dart';

import '../../../env.dart';
import '../helper/helper.dart';
import '../models/address.dart';

class MainController extends ControllerMVC {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  OverlayEntry loader = Helper.overlayLoader();
  late GlobalKey<ScaffoldState> scaffoldKey;

  MainController() {
    scaffoldKey = GlobalKey<ScaffoldState>();
  }
  Future<DateTime?> pickDateTime(BuildContext context) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    // Show Date Picker
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    // Check if the user selected a date
    // Show Time Picker
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      DateTime selectedDateTime = DateTime(
        selectedDate!.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      return selectedDateTime;
    }

    return null;
  }

  // Pick location function
  Future<Address?> pickLocation() async {
    try {
      // LocationData currentLocation = await Location().getLocation();
      LocationResult? result =
          await Navigator.of(scaffoldKey.currentContext!).push(
        MaterialPageRoute(
          builder: (context) => PlacePicker(
            MAP_API,
            defaultLocation: const LatLng(56.1304, 106.3468),
          ),
        ),
      );

      if (result != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            result.latLng!.latitude, result.latLng!.longitude);

        Placemark place = placemarks.first;

        // Return the address details in the specified format
        return Address(
            address: place.street ?? '',
            country: place.country ?? '',
            state: place.administrativeArea ?? '',
            latitude: result.latLng!.latitude,
            longitude: result.latLng!.longitude,
            city: result.city!.name,
            nameAddress: result.name ?? "");
      }

      return null;
    } catch (e) {
      print('Error picking location: $e');
    }
    return null;
  }
}
