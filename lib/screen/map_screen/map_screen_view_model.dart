import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/map_screen/widgets/user_pop_up.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class MapScreenViewModel extends BaseViewModel {
  int selectedDistance = 10;
  List<int> distanceList = [1, 5, 10, 20, 50, 500];
  LatLng center = const LatLng(21.2408, 72.8806);
  List<RegistrationUserData>? userData = [];
  Set<Marker> marker = {};
  List<Place> items = [];
  late GoogleMapController mapController;
  late ClusterManager manager;
  late Position position;

  void init(context) {
    manager = _initClusterManager();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>(
      items,
      _updateMarkers,
      markerBuilder: _markerBuilder,
      levels: [1, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5, 20.0],
      extraPercent: 0.2,
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    marker = markers;
    notifyListeners();
  }

  Future<void> getUserByCoordinatesApiCall(
      {required double latitude,
      required double longitude,
      required int km}) async {
    ApiProvider()
        .getUserByLatLong(latitude: latitude, longitude: longitude, km: km)
        .then((value) async {
      userData = value.data;
      items = [];
      for (int i = 0; i < userData!.length; i++) {
        items.add(
          Place(
            userData: userData?[i],
            latLng: LatLng(
              double.parse(userData![i].lattitude!),
              double.parse(userData![i].longitude!),
            ),
          ),
        );
      }
      manager.setItems(items);
      notifyListeners();
    });
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onMapCreated(GoogleMapController controller) async {
    position = await getUserCurrentLocation();
    getUserByCoordinatesApiCall(
        latitude: position.latitude,
        longitude: position.longitude,
        km: selectedDistance);
    updateProfileApiCall();
    await PrefService.setLatitude(
      position.latitude.toString(),
    );
    await PrefService.setLongitude(
      position.longitude.toString(),
    );
    center = LatLng(position.latitude, position.longitude);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: center,
          zoom: 15.09,
        ),
      ),
    );
    mapController = controller;
    mapController.animateCamera(
      CameraUpdate.newLatLng(center),
    );
    notifyListeners();
  }

  void updateProfileApiCall() async {
    await ApiProvider().updateProfile(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString());
  }

  void onDistanceChange(int value) async {
    Loader().lottieLoader();
    position = await getUserCurrentLocation();
    selectedDistance = value;
    getUserByCoordinatesApiCall(
        latitude: position.latitude,
        longitude: position.longitude,
        km: selectedDistance);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: getZoomLevel(value.toDouble()),
        ),
      ),
    );
    Get.back();
    notifyListeners();
  }

  void onUserProfileTap(
      {required LatLng target,
      RegistrationUserData? data,
      required bool isMultiple}) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: isMultiple ? 10 : 14.47,
        ),
      ),
    );
    isMultiple
        ? null
        : Get.dialog(
            UserPopUp(
                onMoreInfoTap: () {
                  onMoreInfoTap(data);
                },
                onCancelTap: onBackBtnTap,
                image: data?.images == null || data!.images!.isEmpty
                    ? ''
                    : data.images?[0].image,
                userName: data?.fullname,
                live: data?.live),
            barrierColor: Colors.transparent,
          );
  }

  void onMoreInfoTap(RegistrationUserData? data) {
    // user Detail Screen
    Get.back();
    Get.to(() => const UserDetailScreen(), arguments: data);
  }

  double getZoomLevel(double radius) {
    double zoomLevel = 11;
    if (radius > 0) {
      double radiusElevated = radius + radius;
      // double scale = radiusElevated / 5;
      zoomLevel = 16 - log(radiusElevated) / log(2);
    }
    zoomLevel = double.parse(zoomLevel.toStringAsFixed(2));
    return zoomLevel;
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            for (var user in cluster.items) {
              onUserProfileTap(
                  target: LatLng(double.parse(user.userData?.lattitude ?? ''),
                      double.parse(user.userData?.longitude ?? '')),
                  data: user.userData,
                  isMultiple: cluster.isMultiple);
            }
          },
          icon: await _getMarkerBitmap(
              cluster.isMultiple ? 125 : 75, cluster.items.toList(),
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, List<Place> places,
      {String? text}) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.deepOrange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    if (size == 75) {
      if (places[0].userData?.images == null ||
          places[0].userData!.images!.isEmpty) {
        return await MarkerIcon.pictureAsset(
            width: 110, height: 110, assetPath: AssetRes.personLocationPin);
      }
      return await MarkerIcon.downloadResizePictureCircle(
        ConstRes.aImageBaseUrl + (places[0].userData?.images?[0].image ?? ''),
        size: 150,
      );
    } else {
      return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
    }
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      SnackBarWidget().snackBarWidget('$error');
    });
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}

class Place with ClusterItem {
  final RegistrationUserData? userData;
  final LatLng latLng;

  Place({
    required this.userData,
    required this.latLng,
  });

  @override
  LatLng get location => latLng;
}
