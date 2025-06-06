import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Detailspage extends StatefulWidget {
  final List<String> imageurl;
  final String transmition;
  final int milage;
  final int model;
  final String registration;
  final String carname;
  final String company;
  final int enginecapacity;
  final String city;
  final String color;
  final String assembly;
  final DateTime createdAt;
  final String contact;
  final String price;

  Detailspage({
    Key? key,
    required this.imageurl,
    required this.transmition,
    required this.milage,
    required this.model,
    required this.registration,
    required this.carname,
    required this.company,
    required this.enginecapacity,
    required this.city,
    required this.color,
    required this.assembly,
    required this.createdAt,
    required this.contact,
    required this.price,
  }) : super(key: key);

  @override
  State<Detailspage> createState() => _DetailspageState();
}
class _DetailspageState extends State<Detailspage> {

  final CarouselController _controller = CarouselController();
  List<Image> preloadedImages = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var url in widget.imageurl) {
        final image = Image.network(url, fit: BoxFit.cover);
        preloadedImages.add(image);
        // precacheImage(image.image, context);
      }

      setState(() {}); // Trigger rebuild to show images
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30.r,
                        child: Icon(Icons.arrow_back, size: 20.sp, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 150.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21.r),
                      child: Image.asset("assets/images/crl.png", fit: BoxFit.fill),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30.r,
                      child: Icon(Icons.person, size: 20.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
              CarouselSlider(
                items: List.generate(preloadedImages.length, (index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Hero(
                      tag: widget.imageurl[0],
                      child: preloadedImages[index], // Already preloaded Image
                    ),
                  );
                }),
                options: CarouselOptions(
                  height: 250.h,
                  viewportFraction: 1,
                  autoPlay: false,
                  enableInfiniteScroll: false,
                ),
              ),

              SizedBox(height: 10.h),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 4.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.company} ${widget.carname}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 28.sp,
                          color: const Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 4.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.price,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                          color: const Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 350.w,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Vehicle specifications", style: labelStyle.copyWith(fontWeight: FontWeight.w600)),
                            Icon(Icons.keyboard_arrow_down, color: Colors.white),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        buildSpecRow("Company Name", widget.company, "Registration Status", widget.registration),
                        buildSpecRow("Engine", "${widget.enginecapacity}cc", "Year of Issue", widget.model.toString()),
                        buildSpecRow("Box", widget.transmition, "Colour", widget.color),
                        buildSpecRow("Assembly", widget.assembly, "Mileage", "${widget.milage} km"),
                        buildSpecRow("City", widget.city, "Ad uploaded",
                            "${widget.createdAt.day}/${widget.createdAt.month}/${widget.createdAt.year}"),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 350.w,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: Color(0xFFF5F5F5), size: 20.sp),
                        SizedBox(width: 12.w),
                        Text(
                          "Contact Buyer",
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          widget.contact,
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSpecRow(String label1, String value1, String label2, String value2) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label1, style: labelStyle),
              SizedBox(height: 4.h),
              Text(value1, style: valueStyle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(label2, style: labelStyle),
              SizedBox(height: 4.h),
              Text(value2, style: valueStyle),
            ],
          ),

        ],

      ),

    );

  }
}

final valueStyle = TextStyle(
  color: Color(0xFFF5F5F5),
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
);

final labelStyle = TextStyle(
  color: Color(0xFFA1A1A1),
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
);
