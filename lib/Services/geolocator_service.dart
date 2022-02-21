import 'package:geolocator/geolocator.dart';
import 'package:flutter_geocoder/geocoder.dart' as geoCo;
class GeolocatorService {

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  }
  Future<String?> getCurrentAddress() async {
    var positionData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final cords = geoCo.Coordinates(positionData.latitude, positionData.longitude);
    var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
    String? mainAddress = address.first.addressLine;
    return  mainAddress;
  }
}