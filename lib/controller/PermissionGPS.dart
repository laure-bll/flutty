import 'package:geolocator/geolocator.dart';

class PermissionGPS {
  Future <Position> init() async {
    bool isGPSEnabled = await Geolocator.isLocationServiceEnabled();

    if(!isGPSEnabled) {
      return Future.error("GPS service is disabled");
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      return checkPermission(permission);
    }
  }

  checkPermission(LocationPermission permission) {
    switch(permission){
      case LocationPermission.deniedForever : Future.error("");
      case LocationPermission.denied : Geolocator.requestPermission().then((value) => checkPermission(value));
      case LocationPermission.unableToDetermine : Geolocator.requestPermission().then((value) => checkPermission(value));
      case LocationPermission.whileInUse : return Geolocator.getCurrentPosition();
      case LocationPermission.always : return Geolocator.getCurrentPosition();
      default : return Future.error("Error");
    }
  }
}