import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../modelclasses/car_ad_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Detailspage extends StatefulWidget {
  final CarAd_model car;

  const Detailspage({Key? key, required this.car}) : super(key: key);

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Car Details"),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: widget.car.imageurl.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 250.0,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.car.company} ${widget.car.carname}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Price: ${widget.car.price}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoRow("Model", "${widget.car.model}"),
                  _buildInfoRow("Engine", "${widget.car.enginecapacity}cc"),
                  _buildInfoRow("Transmission", widget.car.transmition),
                  _buildInfoRow("Mileage", "${widget.car.milage} km"),
                  _buildInfoRow("Color", widget.car.color),
                  _buildInfoRow("City", widget.car.city),
                  _buildInfoRow("Assembly", widget.car.assembly),
                  _buildInfoRow("Registration", widget.car.registration),
                  SizedBox(height: 16.h),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text(
                   "Contact Seller",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 18.sp,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 SizedBox(height: 8.h),
                 Text(
                   widget.car.contact,
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 16.sp,
                   ),
                 ),
               ],
             ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
