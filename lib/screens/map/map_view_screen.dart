import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  static const LatLng _kigaliCenter = LatLng(-1.9441, 30.0619);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: Consumer<ListingProvider>(
        builder: (context, provider, _) {
          if (provider.listings.isEmpty) {
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

          return FlutterMap(
            options: MapOptions(
              center: _kigaliCenter,
              zoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.kigali_services_directory',
              ),
              MarkerLayer(
                markers: _buildMarkers(provider.listings),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Marker> _buildMarkers(List<ListingModel> listings) {
    return listings.map((listing) {
      return Marker(
        point: LatLng(listing.latitude, listing.longitude),
        width: 50,
        height: 50,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ListingDetailScreen(listing: listing),
              ),
            );
          },
          child: Icon(
            Icons.location_on,
            color: _getMarkerColor(listing.category.displayName),
            size: 50,
          ),
        ),
      );
    }).toList();
  }

  Color _getMarkerColor(String category) {
    if (category.contains('Hospital')) return Colors.red;
    if (category.contains('Police')) return Colors.blue;
    if (category.contains('Restaurant') || category.contains('Café')) {
      return Colors.orange;
    }
    if (category.contains('Park')) return Colors.green;
    return Colors.purple;
  }
}
