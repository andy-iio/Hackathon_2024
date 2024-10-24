import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //to open the webpage after clicking directions
import 'dart:convert';
import 'package:latlong2/latlong.dart'; //for the locations
import 'package:url_launcher/url_launcher.dart'; //also to open the webpage after clicking directions 
import 'dart:async'; //for the timer


class DropoffPage extends StatefulWidget {
  const DropoffPage({super.key});

  @override
  State<DropoffPage> createState() => _DropoffPageState();
}

 class LocationResult {
  final String name;
  final double lat;
  final double lon;
  final double? distance; //distance away from the location that the user inputs
  final String details;

  LocationResult({
    required this.name,
    required this.lat,
    required this.lon,
    this.distance,
    this.details = '',
  });
}

class _DropoffPageState extends State<DropoffPage> {
  final TextEditingController _searchController = TextEditingController();
  List<LocationResult> _searchResults = [];
  List<LocationResult> _nearbyLocations = [];
  bool _isLoading = false;
  Timer? _debounceTimer;

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    try {
      //google notatim api for more info
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/search?'
          'q=$query'
          '&format=json'
          '&limit=5'
          '&countrycodes=ca'  //only shows results in canada 
        ),
        headers: {'User-Agent': 'YourApp/1.0'},// this is for the openstreet map thing 
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = json.decode(response.body);
        setState(() {
          _searchResults = results.map((result) => LocationResult(
            name: result['display_name'],
            lat: double.parse(result['lat']),
            lon: double.parse(result['lon']),
          )).toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching location: ${e.toString()}')),
      );
    }
  }

Future<void> _findNearbyLocations(double lat, double lon) async {
    setState(() {
      _isLoading = true;
      _nearbyLocations = [];
    });

    try {
      //add more queries later if we can think of them
      final query = """
        [out:json][timeout:25];
        (
          node["recycling:electronic"="yes"](around:5000,$lat,$lon);
          way["recycling:electronic"="yes"](around:5000,$lat,$lon);
          node["amenity"="recycling"](around:5000,$lat,$lon);
          way["amenity"="recycling"](around:5000,$lat,$lon);
          node["amenity"="waste_transfer_station"](around:5000,$lat,$lon);
          way["amenity"="waste_transfer_station"](around:5000,$lat,$lon);
          node["shop"="electronics"]["recycling"="yes"](around:5000,$lat,$lon);
          way["shop"="electronics"]["recycling"="yes"](around:5000,$lat,$lon);
        );
        out body;
        >;
        out skel qt;
      """;

      final response = await http.post(
        Uri.parse('https://overpass-api.de/api/interpreter'),
        body: query,
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final elements = result['elements'] as List;
        
        print('Found ${elements.length} elements');
        
        //used to stop getting repeating locations on the list 
        final Set<String> uniqueLocations = {};
        
        final locations = elements.where((e) => e['type'] == 'node').map((e) {
          final distance = _calculateDistance(
            lat, lon,
            e['lat'].toDouble(),
            e['lon'].toDouble(),
          );
          
          String name = _formatLocationName(e['tags']);
          
          return LocationResult(
            name: name,
            lat: e['lat'].toDouble(),
            lon: e['lon'].toDouble(),
            distance: distance,
            details: _extractLocationDetails(e['tags']),
          );
        }).where((location) {
          final isUnique = uniqueLocations.add(location.name);
          return isUnique;
        }).toList();

        //this is to sort it so the nearest one shows up first in the list
        locations.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

        setState(() {
          _nearbyLocations = locations;
        });
        
        if (locations.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No E-Waste recycling locations found nearby. Try searching in a different area.'),
            ),
          );
        }
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error findin locations: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

//show the details
  String _extractLocationDetails(Map<String, dynamic>? tags) {
    if (tags == null) return '';
    
    List<String> details = [];
    
    if (tags['opening_hours'] != null) details.add('Hours: ${tags['opening_hours']}');
    if (tags['phone'] != null) details.add('Phone: ${tags['phone']}');
    if (tags['website'] != null) details.add('Website: ${tags['website']}');
    
    return details.join('\n');
  }

  double _calculateDistance(double startLat, double startLon, double endLat, double endLon) {
    final Distance distance = Distance();
    final double distanceInMeters = distance.as(
      LengthUnit.Kilometer,
      LatLng(startLat, startLon),
      LatLng(endLat, endLon),
    );
    return distanceInMeters;
  }

    String _formatLocationName(Map<String, dynamic>? tags) {
    if (tags == null) return 'E-Waste Recycling';
    
    String baseName = tags['name'] ?? 
                     tags['operator'] ?? 
                     tags['brand'] ?? 
                     'Recycling Location';
                     
    //if the name alreay says ewaste dont repeat it but add for clarification
    if (!baseName.toLowerCase().contains('e-waste') && 
        !baseName.toLowerCase().contains('electronic')) {
      baseName += ' - E-Waste Recycling';
    }
    
    return baseName;
  }

  void _openDirections(double lat, double lon) async {
    //get coords
    final startLocation = _searchController.text;
    final url = 'https://www.openstreetmap.org/directions?'
                'from=${Uri.encodeComponent(startLocation)}&'
                'to=$lat,$lon';
                
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open directions')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Waste Drop-off Locations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Enter your location',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _debounceTimer?.cancel();
                _debounceTimer = Timer(
                  const Duration(milliseconds: 500),
                  () => _searchLocation(value),
                );
              },
            ),
            if (_searchResults.isNotEmpty)
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final result = _searchResults[index];
                      return ListTile(
                        title: Text(result.name),
                        onTap: () {
                          _searchController.text = result.name;
                          _findNearbyLocations(result.lat, result.lon);
                          setState(() => _searchResults = []);
                        },
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _nearbyLocations.length,
                  itemBuilder: (context, index) {
                    final location = _nearbyLocations[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(location.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${location.distance?.toStringAsFixed(1)} km away'),
                            if (location.details.isNotEmpty)
                              Text(
                                location.details,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => _openDirections(
                            location.lat,
                            location.lon,
                          ),
                          child: const Text('Directions'),
                        ),
                        isThreeLine: location.details.isNotEmpty,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
    }
  }