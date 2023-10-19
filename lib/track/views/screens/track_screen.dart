import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vestago_task/track/view_models/tracking_provider.dart';
import 'package:vestago_task/track/views/widgets/delivery_partner_card.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackProvider>(
      builder: (context, trackProvider, child) => _ui(context, trackProvider),
    );
  }

  Widget _ui(BuildContext, TrackProvider provider) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          (provider.fetchingLocation || provider.currentLocation == null)
              ? const Center(child: CupertinoActivityIndicator())
              : GoogleMap(
                  onMapCreated: (controller) {
                    provider.mapController.complete(controller);
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("current_location"),
                      position: LatLng(
                        provider.currentLocation!.latitude!,
                        provider.currentLocation!.longitude!,
                      ),
                      icon: provider.currentLocationIcon,
                    ),
                    Marker(
                      markerId: const MarkerId("destination"),
                      position: provider.destination,
                      icon: provider.destinationIcon,
                    ),
                  },
                  polylines: provider.polyline,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      provider.currentLocation!.latitude!,
                      provider.currentLocation!.longitude!,
                    ),
                    zoom: 13,
                  ),
                ),
          const Positioned(
            bottom: 0, // Adjust the position as needed
            left: 0, // Adjust the position as needed
            right: 0, // Adjust the position as needed
            child: DeliveryPartnerCard(),
          ),
        ],
      ),
    );
  }
}

