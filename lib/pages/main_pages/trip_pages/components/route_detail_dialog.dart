import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../services/api_services.dart';

class RouteDetailDialog {
  static void show(BuildContext context, String routeId) async {
    final route = await ApiService.getRouteById(routeId);
    final routeLocations = await ApiService.getRouteLocationsById(routeId);

    // Load the image
    const AssetImage routeMapImage =
        AssetImage('lib/assets/images/route_map.png');
    const Image image = Image(image: routeMapImage);

    // Create a list of DataRow for the DataTable
    List<DataRow> locationRows = routeLocations.map((location) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text('${location.index + 1}')),
          DataCell(
            Container(
              width: 100, // Adjust the width to your preference
              child: Text(location.name,
                  overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
          DataCell(Text(location.location.locationType.name ?? 'N/A')),
        ],
      );
    }).toList();

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Route Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image at the top center
                const Center(child: image),

                // Rest of the content
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    route.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text('Description: ${route.description}'),

                Container(
                  margin: const EdgeInsets.only(
                      top: 20), // Adjust the value to set the desired margin
                  child: const Text(
                    'Index Order of Route',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                DataTable(
                  columnSpacing: 20, // Adjust the spacing between columns
                  // ignore: deprecated_member_use
                  dataRowHeight: 70, // Adjust the row height as needed
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('Index',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Location',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Type',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: locationRows,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
