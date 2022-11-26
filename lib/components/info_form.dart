import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ui_repository/components/current_position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InfoForm extends StatefulWidget {
  const InfoForm({Key? key}) : super(key: key);

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  late Future<Position> position;

  @override
  void initState() {
    super.initState();
    position = getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<Position>(
          future: position,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return OutlinedButton(
                  onPressed: () {
                    GoogleMap(
                        initialCameraPosition: CameraPosition(
                      target: LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude),
                      zoom: 18,
                    ));
                  },
                  child: Text('지도'));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text('상세사고정보 출력단'),
        SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("닫기"))
      ],
    );
  }
}
