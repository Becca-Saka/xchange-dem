import 'package:geolocator/geolocator.dart';
import 'package:xchange/barrel.dart';

Future<Position> checkLocationPermmission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    errorSnackbar(msg: 'Location services are disabled.');
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      errorSnackbar(msg: 'Location permissions are denied');
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

Future<bool> requestLocationPermmission() async {
  bool serviceEnabled;
  bool isGranted = false;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    errorSnackbar(msg: 'Location services are disabled.');
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    isGranted = false;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      isGranted = false;
      errorSnackbar(
          msg:
              'Location permissions denied, you need to grant access to continue');
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    isGranted = false;
    Get.defaultDialog(
      buttonColor: appColor,
      onConfirm: () {
        Geolocator.openLocationSettings();
      },
      onCancel: () {
        Get.back();
      },
      radius: 10,
      contentPadding: EdgeInsets.all(22),
      textConfirm: 'Open App Settings',
      confirmTextColor: Colors.white,
      cancelTextColor: appColor,
      title: 'Location permissions are permanently denied',
      content: Text(
          'You need to grant access to continue. Please go to your settings and manually grant access to the app.'),
    );

    return Future.error('Location permissions are permanently denied');
  }
  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
    isGranted = true;
  }
  return isGranted;
}

Future<Position> determinePosition() async {
  return await Geolocator.getCurrentPosition();
}
