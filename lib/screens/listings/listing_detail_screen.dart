import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../../models/listing_model.dart';
import '../../models/category.dart';
import '../../providers/auth_provider.dart';
import 'edit_listing_screen.dart';
import '../map/map_view_screen.dart';

class ListingDetailScreen extends StatefulWidget {
  final ListingModel listing;

  const ListingDetailScreen({super.key, required this.listing});

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  LatLng? _currentLocation;
  double? _distance;
  int? _estimatedMinutes;
  bool _loadingLocation = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _loadingLocation = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _loadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _loadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _loadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _calculateRoute();
        _loadingLocation = false;
      });
    } catch (e) {
      setState(() => _loadingLocation = false);
    }
  }

  void _calculateRoute() {
    if (_currentLocation == null) return;

    final Distance distance = const Distance();
    final double distanceInMeters = distance.as(
      LengthUnit.Meter,
      _currentLocation!,
      LatLng(widget.listing.latitude, widget.listing.longitude),
    );

    setState(() {
      _distance = distanceInMeters / 1000;
      _estimatedMinutes = ((distanceInMeters / 1000) / 40 * 60).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isOwner = authProvider.user?.uid == widget.listing.createdBy;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listing.name),
        actions: [
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditListingScreen(listing: widget.listing),
                  ),
                );
              },
            ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_loadingLocation)
              Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0xFF1A3F6B),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Getting your location...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            else if (_distance != null && _estimatedMinutes != null)
              _buildRouteInfo(),
            _buildMap(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildCategory(),
                  const SizedBox(height: 16),
                  _buildInfoSection(),
                  const SizedBox(height: 24),
                  _buildNavigationButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    List<LatLng> routePoints = [];
    LatLng centerPoint =
        LatLng(widget.listing.latitude, widget.listing.longitude);
    double zoom = 15.0;

    if (_currentLocation != null) {
      routePoints = [
        _currentLocation!,
        LatLng(widget.listing.latitude, widget.listing.longitude),
      ];

      centerPoint = LatLng(
        (_currentLocation!.latitude + widget.listing.latitude) / 2,
        (_currentLocation!.longitude + widget.listing.longitude) / 2,
      );
      zoom = 13.0;
    }

    return SizedBox(
      height: 250,
      child: FlutterMap(
        options: MapOptions(
          center: centerPoint,
          zoom: zoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.kigali_services_directory',
          ),
          if (routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: routePoints,
                  strokeWidth: 4.0,
                  color: const Color(0xFF1A3F6B),
                ),
              ],
            ),
          MarkerLayer(
            markers: [
              if (_currentLocation != null)
                Marker(
                  point: _currentLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.my_location,
                    color: Color(0xFFFFB54C),
                    size: 40,
                  ),
                ),
              Marker(
                point:
                    LatLng(widget.listing.latitude, widget.listing.longitude),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A3F6B),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildRouteInfoItem(
            Icons.straighten,
            '${_distance!.toStringAsFixed(1)} km',
            'Distance',
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white24,
          ),
          _buildRouteInfoItem(
            Icons.access_time,
            '$_estimatedMinutes min',
            'Est. Time',
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFFFB54C), size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.listing.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                widget.listing.address,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        widget.listing.category.displayName,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(Icons.phone, 'Contact', widget.listing.contactNumber),
        const SizedBox(height: 16),
        _buildInfoRow(
          Icons.description,
          'Description',
          widget.listing.description,
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton() {
    return ElevatedButton.icon(
      onPressed: _openMapNavigation,
      icon: const Icon(Icons.directions),
      label: const Text('Get Directions'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  void _openMapNavigation() {
    if (_currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Getting your location... Please try again in a moment'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapViewScreen(
          currentLocation: _currentLocation,
          destinationLocation: LatLng(
            widget.listing.latitude,
            widget.listing.longitude,
          ),
          destinationName: widget.listing.name,
        ),
      ),
    );
  }
}
