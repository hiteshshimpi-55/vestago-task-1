import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vestago_task/track/view_models/tracking_provider.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrackProvider(),
      child: Consumer<TrackProvider>(
        builder: (context, trackProvider, child) => _ui(context, trackProvider),
      ),
    );
  }

  Widget _ui(BuildContext, TrackProvider provider) {
    return Scaffold(
        body: provider.fetchingLocation
            ? const Center(child: CupertinoActivityIndicator())
            : GoogleMap(
              onMapCreated: (controller){
                provider.mapController.complete(controller);
              },
              markers: {
                Marker(
                  markerId: const MarkerId("current_location"),
                  position: LatLng(
                    provider.currentLocation!.latitude!, 
                    provider.currentLocation!.longitude!
                    ),
                  icon: provider.currentLocationIcon  
                  ),
                Marker(
                  markerId: const MarkerId("destination"),
                  position: provider.destination,
                  icon: provider.destinationIcon  
                  )  
              },
              polylines: provider.polyline,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  provider.currentLocation!.latitude!, 
                  provider.currentLocation!.longitude!
                  ),
                zoom: 13  
              )
              ));
  }
}
