import 'dart:collection';
import 'dart:ui' as ui;

import 'package:flutkit/animation/shopping_manager/model/order.dart';
import 'package:flutkit/animation/shopping_manager/shopping_cache.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/theme/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  final Order order;
  GoogleMapController? mapController;
  final LatLng center = LatLng(37.404049, -122.114016);
  final startLocation = LatLng(37.400987, -122.113969);
  final deliveryBoyLocation = LatLng(37.401709, -122.113483);
  final deliveryLocation = LatLng(37.406441, -122.113856);
  final Set<Polyline> polylines = HashSet();
  final Set<Marker> markers = HashSet();
  BitmapDescriptor? deliveryPinIcon, shopPinIcon, deliveryBoyPinIcon;

  OrderController(this.order);

  @override
  void onInit() {
    super.onInit();
    initMapAssets();
  }

  initMapAssets() async {
    List<LatLng> points = [
      LatLng(37.406441, -122.113856),
      LatLng(37.406435, -122.113713),
      LatLng(37.406258, -122.113462),
      LatLng(37.406015, -122.113083),
      LatLng(37.405688, -122.112591),
      LatLng(37.405477, -122.112229),
      LatLng(37.405301, -122.111950),
      LatLng(37.405113, -122.111638),
      LatLng(37.405019, -122.111488),
      LatLng(37.404928, -122.111516),
      LatLng(37.403258, -122.112515),
      LatLng(37.402380, -122.113030),
      LatLng(37.401775, -122.113422),
    ];

    polylines.addAll([
      Polyline(
          polylineId: PolylineId("1"),
          points: points,
          width: 2,
          color: theme.colorScheme.primary)
    ]);

    deliveryPinIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset(ShoppingCache.deliveryIcon, 56));
    shopPinIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset(ShoppingCache.shopIcon, 100));
    deliveryBoyPinIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset(ShoppingCache.deliveryBoyIcon, 64));
    markers.addAll([
      Marker(
        markerId: MarkerId('shop'),
        position: startLocation,
        icon: shopPinIcon!,
      ),
      Marker(
        markerId: MarkerId('delivery_boy'),
        position: deliveryBoyLocation,
        icon: deliveryBoyPinIcon!,
      ),
      Marker(
        markerId: MarkerId('delivery'),
        position: deliveryLocation,
        icon: deliveryPinIcon!,
      ),
    ]);

    update();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    String mapStyle = await rootBundle.loadString(
        AppTheme.themeType == ThemeType.light
            ? ShoppingCache.lightMap
            : ShoppingCache.darkMap);
    if (mapController != null) {
      mapController!.setMapStyle(mapStyle);
    }
    update();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void goBack() {
    Get.back();
    // Navigator.pop(context);
  }
}
