// search_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pakwheels/modelclasses/car_ad_model.dart';

import '../providers/search_provider.dart';

class CarSearchPage extends StatefulWidget {
  const CarSearchPage({Key? key}) : super(key: key);

  @override
  State<CarSearchPage> createState() => _CarSearchPageState();
}

class _CarSearchPageState extends State<CarSearchPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _engineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Search Cars')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(_nameController, 'Car Name'),
            _buildTextField(_companyController, 'Company'),
            _buildTextField(_cityController, 'City'),
            _buildTextField(_engineController, 'Engine Capacity'),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                searchProvider.searchCars(
                  name: _nameController.text.trim(),
                  company: _companyController.text.trim(),
                  city: _cityController.text.trim(),
                  enginecapacity: _engineController.text.trim(),
                  context: context,
                );
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),

            if (searchProvider.isLoading)
              const CircularProgressIndicator()
            else if (searchProvider.hasSearched &&
                searchProvider.searchResults.isEmpty)
              const Text("No cars found")
            else
              Expanded(
                child: ListView.builder(
                  itemCount: searchProvider.searchResults.length,
                  itemBuilder: (context, index) {
                    final car = searchProvider.searchResults[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: car.imageurl.isNotEmpty
                            ? Image.network(car.imageurl[0], width: 60, fit: BoxFit.cover)
                            : const Icon(Icons.directions_car),
                        title: Text("${car.company.toUpperCase()} ${car.carname}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Model: ${car.model}, Engine: ${car.enginecapacity}cc"),
                            Text("Transmission: ${car.transmition}"),
                            Text("Mileage: ${car.milage} km"),
                            Text("City: ${car.city}, Color: ${car.color}"),
                            Text("Assembly: ${car.assembly}"),
                          ],
                        ),
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

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
