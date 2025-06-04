import 'package:flutter/material.dart';
import 'package:pakwheels/providers/search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController engineCapacityController = TextEditingController();

  @override
  void dispose() {
    carNameController.dispose();
    companyController.dispose();
    cityController.dispose();
    engineCapacityController.dispose();
    super.dispose();
  }

  void runSearch() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.searchCars(
      name: carNameController.text.trim(),
      company: companyController.text.trim(),
      city: cityController.text.trim(),
      enginecapacity: engineCapacityController.text.trim(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final searchResults = searchProvider.searchResults;
    final isLoading = searchProvider.isLoading;
    final hasSearched = searchProvider.hasSearched;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Cars"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Filters
            TextField(
              controller: carNameController,
              decoration: const InputDecoration(labelText: 'Car Name'),
            ),
            TextField(
              controller: companyController,
              decoration: const InputDecoration(labelText: 'Company'),
            ),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: engineCapacityController,
              decoration: const InputDecoration(labelText: 'Engine Capacity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: runSearch,
              child: const Text("Search"),
            ),
            const SizedBox(height: 20),

            // Search Results
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : hasSearched
                  ? searchResults.isEmpty
                  ? const Center(child: Text("No results found"))
                  : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final ad = searchResults[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: ad.imageurl != null
                          ? Image.network(ad.imageurl[0], width: 60, height: 60, fit: BoxFit.cover)
                          : const Icon(Icons.directions_car),
                      title: Text(ad.carname ?? "Unknown"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Company: ${ad.company ?? 'N/A'}"),
                          Text("City: ${ad.city ?? 'N/A'}"),
                          Text("Engine: ${ad.enginecapacity ?? 'N/A'}"),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : const Center(child: Text("Enter search criteria and press Search")),
            ),
          ],
        ),
      ),
    );
  }
}
