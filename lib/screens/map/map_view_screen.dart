import 'package:flutter/foundation.dart' show kIsWeb;
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
          // Show list view on web instead of map (Google Maps Flutter doesn't work well on web)
          if (kIsWeb) {
            return _buildWebListView(provider.listings);
          }

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

  // Web alternative: show list with location info instead of map
  Widget _buildWebListView(List<ListingModel> listings) {
    if (listings.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No listings available',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: listings.length,
      itemBuilder: (context, index) {
        final listing = listings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(
              _getCategoryIcon(listing.category.displayName),
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
            title: Text(listing.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(listing.category.displayName),
                Text(listing.address, style: const TextStyle(fontSize: 12)),
                Text(
                  'Coordinates: ${listing.latitude.toStringAsFixed(4)}, ${listing.longitude.toStringAsFixed(4)}',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ListingDetailScreen(listing: listing),
                ),
              );
            },
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    if (category.contains('Hospital')) return Icons.local_hospital;
    if (category.contains('Police')) return Icons.local_police;
    if (category.contains('Library')) return Icons.local_library;
    if (category.contains('Restaurant')) return Icons.restaurant;
    if (category.contains('Café')) return Icons.local_cafe;
    if (category.contains('Park')) return Icons.park;
    if (category.contains('Tourist')) return Icons.tour;
    return Icons.place;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
