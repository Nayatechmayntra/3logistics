import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/api_string.dart';
import '../Api/network_call.dart';
import '../modal/currentlocation_model.dart';
import '../modal/startNavigation.dart';
import '../modal/stopNavigation.dart';

class CurrentlocationController extends GetxController {
  var latitude = ''.obs;
  var longitude = ''.obs;
  late StreamSubscription<Position> streamSubscription;
  var address = 'Getting Address..'.obs;
  String? token;
  var loader = false.obs;
  late StartNavigation startNavigation;
  late StopNavigation stopNavigation;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  checktoken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("login");
    // forgotpassController.changePasswordApi(context,preferences.getString("login")!);
  }

  currentLocationApi(String token) async {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["latitude"] = latitude.value;
    map["longitude"] = longitude.value;
    map["address"] = address.value;
    print("Token::::::${token}");
    print("map::::::${map}");

    Webservice().loadPostWithToken(getcurrentlocationApi, map, token).then(
          (model) async => {
            print("Token currentlocation::::::${token}"),
            if (model.status == "200")
              {
                if (model.status == "0")
                  {
                    print('st 0 ${model.status}'),
                  }
                else
                  {
                    // addBoolToSF(true, model),
                    print('st new ${model.status}'),
                    print('new longitude${model.data!.longitude}'),
                    print('new latitude${model.data!.latitude}'),
                    print('new address${model.data!.address}'),
                  },
                //     Get.offAll(HomePage())
              }
            else
              {
                // print(model.data!.username),
                // Get.offAll(LoginScreen()),
                // addBoolToSF(false, model),
              },
            // {storage.write(isLogin, false)}
          },
        );
  }

  Resource<Currentlocation> get getcurrentlocationApi {
    return Resource(
        url: ApiString.currentlocation,
        parse: (response) {
          var result;
          if (response.body.isNotEmpty) {
            result = json.decode(response.body);
          } else {
            print("empty responce");
          }
          print("" +
              ".......getSuppliercurrentlocation......" +
              result.toString());
          String success = result["status"].toString();
          if (success == "200") {
            return currentlocationFromJson(response.body);
          } else {
            // loader.value = false;
            String message = result["message"];
            Get.snackbar(
                duration: Duration(milliseconds: 1200),
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                margin: EdgeInsets.only(),
                borderRadius: 0,
                backgroundColor: Color(0xff41069D),
                "",
                message);
            return currentlocationFromJson(response.body);
          }
        });
  }


  startNavigationApi(
      String token,
      ) async {
    loader.value = true;
    Webservice()
        .loadGetWithToken(
      getStartNavigation,
      token,
    )
        .then(
          (model) => {
        print("following name is::" + model.data.toString()),
        if (model.status == "200") {} else {}
      },
    );
  }

  Resource<StartNavigation> get getStartNavigation {
    return Resource(
        url: ApiString.startNavigation,
        parse: (response) {
          //print("Following Api::::::::${"https://api.mimap.website/v1/user/myfollowing/?page=$currentPage"}");

          print("StartNavigation Api::::::::${ApiString.startNavigation}");
          print("StartNavigation Response::::::::${response.body}");

          var result;
          if (response.body.isNotEmpty) {
            result = json.decode(response.body);
            print("Following Response::::::::${response.body}");
          } else {
            print("empty response");
          }
          print("" + "..... ..getSupplier......" + result.toString());

          String success = response.statusCode.toString();
          if (success == "200") {
            loader.value = false;

            startNavigation = StartNavigation.fromJson(json.decode(response.body));
            print("List size:::::${startNavigation.data}");

            return startNavigationFromJson(response.body);
          } else {
            loader.value = false;
            Timer(const Duration(milliseconds:000), () async {
              //CustomLoder.hideProgressDialog(context!);
              String message = result["message"];
              print("check message:::::" + message);
              Get.snackbar(
                  duration: Duration(milliseconds: 1200),
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                  margin: EdgeInsets.only(),
                  borderRadius: 0,
                  backgroundColor: Color(0xff41069D),
                  "",
                  message);
            });

            return startNavigationFromJson(response.body);
          }
        });
  }

  stopNavigationtApi(
      String token,
      ) async {
    loader.value = true;
    Webservice()
        .loadGetWithToken(
      getstopNavigation,
      token,
    )
        .then(
          (model) => {
        print("stopNavigation is::" + model.data.toString()),
        if (model.status == "200") {} else {}
      },
    );
  }

  Resource<StopNavigation> get getstopNavigation {
    return Resource(
        url: ApiString.startNavigation,
        parse: (response) {
          //print("Following Api::::::::${"https://api.mimap.website/v1/user/myfollowing/?page=$currentPage"}");

          print("Stop Navigation Api::::::::${ApiString.startNavigation}");
          print("Stop Navigation Response::::::::${response.body}");

          var result;
          if (response.body.isNotEmpty) {
            result = json.decode(response.body);
            print("stop Navigation Response::::::::${response.body}");
          } else {
            print("empty response");
          }
          print("" + "..... ..getSupplier......" + result.toString());

          String success = response.statusCode.toString();
          if (success == "200") {
            loader.value = false;

            stopNavigation = StopNavigation.fromJson(json.decode(response.body));
            print("List size:::::${startNavigation.data}");

            return stopNavigationFromJson(response.body);
          } else {
            loader.value = false;
            Timer(const Duration(milliseconds:000), () async {
              //CustomLoder.hideProgressDialog(context!);
              String message = result["message"];
              print("check message:::::" + message);
              Get.snackbar(
                  duration: Duration(milliseconds: 1200),
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                  margin: EdgeInsets.only(),
                  borderRadius: 0,
                  backgroundColor: Color(0xff41069D),
                  "",
                  message);
            });

            return stopNavigationFromJson(response.body);
          }
        });
  }



  getLocation() async {
    Timer mytimer = Timer.periodic(Duration(seconds: 15), (timer) {
      //code to run on every 5 seconds
    });

    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude.value = '${position.latitude}';
      longitude.value = '${position.longitude}';
      print('current Latitude naya:::::${latitude.value}');
      print('current Longitude naya:::::${longitude.value}');
      getAddressFromLatLang(position);
    });
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address.value =
        '${place.street},${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}';
    //currentLocationApi("YmdxYzBONGJmZEY3OGl2bDc1Z2phWXZvR1JJdWdEWDF5UGdBV0Z6ekdkcEl2YzVpd05DQmE2eUFCMlBY64019b1d61efe");
    print('current Address naya:::::${address.value}');
  }
}
