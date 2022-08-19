import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:exif/exif.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

part 'theta_event.dart';
part 'theta_state.dart';

class ThetaBloc extends Bloc<ThetaEvent, ThetaState> {
  ThetaBloc() : super(ThetaState.initial()) {
    on<GetGPSPhoneEvent>((event, emit) async {
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();

      emit(ThetaState(
        responseWindowState: ResponseWindowState.phoneGPS,
        latitude: _locationData.latitude!,
        longitude: _locationData.longitude!,
        altitude: _locationData.altitude!,
        time: _locationData.time!,
      ));
    });

    on<SetGPSEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      DateTime date =
          DateTime.fromMicrosecondsSinceEpoch(state.time.toInt() * 1000);
      String month = date.month.toString();
      if (date.month < 10) {
        month = "0${date.month}";
      }

      var bodyMap = {
        'name': 'camera.setOptions',
        'parameters': {
          'options': {
            'gpsInfo': {
              "lat": state.latitude,
              "lng": state.longitude,
              "_altitude": state.altitude,
              "_dateTimeZone": "${date.year}:05:18 01:04:29+08:00",
              "_datum": "WGS84"
            }
          }
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      print(bodyJson);
      print(response.body);
      emit(state.copyWith(
          message: response.body,
          responseWindowState: ResponseWindowState.setGPS));
    });
    on<GetGPSEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.getOptions',
        'parameters': {
          'optionNames': ['gpsInfo']
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      print("GET GPS INFO: ${response.body}");
      emit(state.copyWith(
          message: response.body,
          responseWindowState: ResponseWindowState.getGPS));
    });
    on<TakePicEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {'name': 'camera.takePicture'};
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      emit(state.copyWith(
          message: response.body,
          responseWindowState: ResponseWindowState.takePic));
    });
    on<GetFileEvent>((event, emit) async {
      var url = Uri.parse('http://192.168.1.1/osc/commands/execute');
      var header = {'Content-Type': 'application/json;charset=utf-8'};
      var bodyMap = {
        'name': 'camera.listFiles',
        'parameters': {
          'fileType': 'image',
          'startPosition': 0,
          'entryCount': 1,
          'maxThumbSize': 0
        }
      };
      var bodyJson = jsonEncode(bodyMap);
      var response = await http.post(url, headers: header, body: bodyJson);
      var convertResponse = jsonDecode(response.body);
      var fileUrl = convertResponse['results']['entries'][0]['fileUrl'];
      emit(state.copyWith(fileUrl: fileUrl));
      add(GallerySaveEvent());
    });
    on<GallerySaveEvent>((event, emit) async {
      print('saving image to phone');
      await GallerySaver.saveImage(state.fileUrl).then((value) {
        print("Path from Gallery Saver: ");
        emit(state.copyWith(
            responseWindowState: ResponseWindowState.savedImage));
      });
    });
    on<ImagePickEvent>((event, emit) async {
      emit(state.copyWith(image: event.image));
      print(state.image!.path.toString());
    });
    on<GetMetadataEvent>((event, emit) async {
      final fileBytes = File(state.image!.path).readAsBytesSync();
      final data = await readExifFromBytes(fileBytes);
      if (data.isEmpty) {
        print("no exif data found");
        return;
      }
      emit(state.copyWith(
          responseWindowState: ResponseWindowState.metaData,
          message:
              'Latitude: ${data['GPS GPSLatitude']} Longitude: ${data['GPS GPSLongitude']}'));
      print(
          'Latitude: ${data['GPS GPSLatitude']} Longitude: ${data['GPS GPSLongitude']}');
    });
  }
}
