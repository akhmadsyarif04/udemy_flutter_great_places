import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);

    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text('no location chosen', textAlign: TextAlign.center)
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton.icon(
            onPressed: _getCurrentUserLocation,
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.map),
            label: Text('Select on map'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    ]);
  }
}
