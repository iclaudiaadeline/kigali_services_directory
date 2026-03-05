import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/listing_provider.dart';
import '../../models/listing_model.dart';
import '../../models/category.dart';
import '../listings/listing_detail_screen.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  // Kigali coordinates
  static const LatLng _kigaliCenter = LatLng(-1.9441, 30.0619);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: Consumer<ListingProvider>(
        builder: (context, provider, _) {
          _updateMarkers(provider.listings);

          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _kigaliCenter,
              zoom: 12,
            ),
            markers: _markers,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
          );
        },
      ),
    );
  }

  void _updateMarkers(List<ListingModel> listings) {
    _markers = listings.map((listing) {
      return Marker(
        markerId: MarkerId(listing.id ?? ''),
        position: LatLng(listing.latitude, listing.longitude),
        infoWindow: InfoWindow(
          title: listing.name,
          snippet: listing.category.displayName,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ListingDetailScreen(listing: listing),
              ),
            );
          },
        ),
        icon: _getMarkerIcon(listing.category.displayName),
      );
    }).toSet();
  }

  BitmapDescriptor _getMarkerIcon(String category) {
    // You can customize marker colors based on category
    return BitmapDescriptor.defaultMarkerWithHue(
      category.contains('Hospital')
          ? BitmapDescriptor.hueRed
          : category.contains('Police')
              ? BitmapDescriptor.hueBlue
              : category.contains('Restaurant') || category.contains('Café')
                  ? BitmapDescriptor.hueOrange
                  : category.contains('Park')
                      ? BitmapDescriptor.hueGreen
                      : BitmapDescriptor.hueViolet,
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
