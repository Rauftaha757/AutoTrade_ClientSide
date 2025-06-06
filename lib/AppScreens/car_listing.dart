import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pakwheels/modelclasses/car_ad_model.dart';
import 'package:pakwheels/providers/Car_ad_provider.dart';
import 'package:provider/provider.dart';

import '../providers/search_provider.dart';
import 'cardetailspage.dart';

class CarListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CarListingPage();
}

class _CarListingPage extends State<CarListingPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAds();
  }
  bool flagserach=false;
  void fetchAds() async {
    await Provider.of<CarAdProvider>(context, listen: false).fetchAds(context);
    setState(() {
      isLoading = false;
    });
  }
  String ? selectedCompany ; // Declare this in your StatefulWidget
  String ? engine; // Declare this in your StatefulWidget
  String ? city ;
  TextEditingController companyController =TextEditingController();
  TextEditingController carnameController=TextEditingController();
  TextEditingController engineccController=TextEditingController();
  TextEditingController cityController  =TextEditingController();
  @override
  Widget build(BuildContext context) {


    final List<String> carCompanies = [
      'Toyota', 'Honda', 'Suzuki', 'Hyundai', 'Kia', 'Nissan', 'Mazda', 'Chevrolet', 'BMW',
      'Mercedez', 'Audi', 'Lexus', 'Mitsubishi', 'Daihatsu', 'Subaru', 'Isuzu', 'Changan',
      'FAW', 'Proton', 'Geely', 'Peugeot', 'Renault', 'Fiat', 'Ford', 'Volkswagen', 'Skoda',
      'Tesla', 'Genesis', 'Buick', 'Cadillac', 'Chrysler', 'Dodge', 'Jeep', 'Lincoln', 'Mini',
      'Opel', 'Volvo', 'RAM', 'Saab', 'Seat', 'Hummer', 'Pontiac', 'Scion', 'Smart', 'Tata',
      'Great Wall', 'JAC', 'BYD', 'Baic', 'MG', 'Lifan', 'Zotye', 'Land Rover', 'Jaguar'
    ];
    List<int> carEngineCapacities = [
      660, 800, 1000, 1300, 1500, 1800, 2000,
      2400, 2500, 2800, 3000, 3500, 4000, 4500, 5000
    ];

    final List<String> cities = [
      'Lahore', 'Karachi', 'Islamabad', 'Rawalpindi', 'Faisalabad',
      'Multan', 'Peshawar', 'Quetta', 'Gujranwala', 'Sialkot',
      'Hyderabad', 'Bahawalpur', 'Sargodha', 'Sukkur', 'Larkana',
      'Sheikhupura', 'Rahim Yar Khan', 'Jhang', 'Dera Ghazi Khan',
      'Abbottabad', 'Mardan', 'Okara', 'Mingora', 'Chiniot', 'Kasur',
      'Gujrat', 'Sahiwal', 'Nawabshah', 'Mirpur', 'Kotli',
      'Muzaffarabad', 'Gilgit', 'Skardu',
    ];
    Future<void> _refreshAds() async {
      setState(() {
        isLoading = true;
        flagserach = false;
        carnameController.clear();
        companyController.clear();
        engineccController.clear();
        cityController.clear();
      });
      await Provider.of<CarAdProvider>(context, listen: false).fetchAds(context);
      setState(() {
        isLoading = false;
      });
    }

    void runSearch() {
      final searchProvider = Provider.of<SearchProvider>(context, listen: false);
      searchProvider.searchCars(
        name: carnameController.text.trim(),
        company: companyController.text.trim(),
        city: cityController.text.trim(),
        enginecapacity: engineccController.text.trim(),
        context: context,
      );
      flagserach=!flagserach;
    }
    final addlist = Provider.of<CarAdProvider>(context).ads;
    final searchProvider = Provider.of<SearchProvider>(context);
    final searchResults = searchProvider.searchResults;
    final isLoadingsearch = searchProvider.isLoading;
    final hasSearched = searchProvider.hasSearched;
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
    body: SafeArea(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // App name
 Row(
   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
   children: [
     Padding(
       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
       child: CircleAvatar(
         backgroundColor: Colors.black,
         radius: 30.r,
         child: Icon(Icons.arrow_back,size: 20.sp,color: Colors.white,),
       )
     ),
   Container(
     width: 150.w,
     height: 56.h,
   decoration: BoxDecoration(
     color: Colors.white,
     borderRadius: BorderRadius.circular(21.r)
   ),
child: ClipRRect(
  borderRadius: BorderRadius.circular(21.r),
  child: Image.asset("assets/images/crl.png",fit: BoxFit.fill,)),
   ),
     Padding(
         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
         child: CircleAvatar(
           backgroundColor: Colors.black,
           radius: 30.r,
           child: Icon(Icons.person,size: 20.sp,color: Colors.white,),
         )
     ),
   ],
 ),

    // Search bar
      Center(
        child: Container(
          width: 350.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: TextField(
              controller: carnameController,
              style: TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14.sp),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,weight:700,),
               suffixIcon: GestureDetector(
                 onTap: (){
                   runSearch();
                 },
                   child: Icon(Icons.search_rounded,color: Colors.red)),
               hintText: "Search Cars by name",
                hintStyle: TextStyle(color: const Color(0xFFA1A1A1), fontSize: 14.sp),
                border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              cursorColor: const Color(0xFFF5F5F5),
            ),
          ),
        ),
      ),
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(
        padding:  EdgeInsets.all(8.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(21.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCompany,
              hint: Text("Select company", style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),),
              dropdownColor: Colors.black87,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              items: carCompanies.map((company) {
                return DropdownMenuItem<String>(
                  value: company,
                  child: Row(
                    children: [
                      Icon(Icons.business, color: Colors.white, size: 16.sp),
                      SizedBox(width: 8.w),
                      Text(company),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCompany = value!;
                 if(value!=null && value.isNotEmpty){
                   companyController.text = value ?? '';
                 }
                });
              },
            ),
          ),
        ),
      ),


      Padding(
        padding: EdgeInsets.all(8.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(21.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: engine,
              hint: Text("Select Engine(cc)", style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),),
              dropdownColor: Colors.black87,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              items: carEngineCapacities.map((capacity) {
                String capacityStr = capacity.toString();
                return DropdownMenuItem<String>(
                  value: capacityStr,
                  child: Row(
                    children: [
                      Icon(Icons.speed, color: Colors.white, size: 16.sp),
                      SizedBox(width: 8.w),
                      Text(capacityStr),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  engine = value!;
                if(value!=null && value.isNotEmpty){
                  engineccController.text = value;
                }
                });
              },
            ),
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.all(8.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(21.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: city,
              hint: Text("Select City", style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),),
              dropdownColor: Colors.black87,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              items: cities.map((cityName) {
                return DropdownMenuItem<String>(
                  value: cityName,
                  child: Row(
                    children: [
                      Icon(Icons.location_city, color: Colors.white, size: 16.sp),
                      SizedBox(width: 8.w),
                      Text(cityName),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  city = value!;
                  if(value!=null && value.isNotEmpty){
                    cityController.text = value;
                  }
                });
              },
            ),
          ),
        ),
      ),

    ],
  ),
),
      SizedBox(height: 8.h),

    // Ads List / Loader
      Expanded(
        child: isLoading || isLoadingsearch
            ? Center(
          child: SpinKitWave(
            color: Colors.white,
            itemCount: 5,
            size: 35.sp,
          ),
        )
            : (searchResults.isEmpty && flagserach)
            ? Center(
          child: Text(
            "No ads found for your search",
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        )
            : (!flagserach && addlist.isEmpty)
            ? Center(
          child: Text(
            "No ads available",
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        )
            : Padding(
          padding: EdgeInsets.all(8.r),
          child: RefreshIndicator(
            onRefresh: _refreshAds,
            child: ListView.builder(
              itemCount: searchResults.isEmpty
                  ? addlist.length
                  : searchResults.length,
              itemBuilder: (context, index) {
                final ad = searchResults.isEmpty
                    ? addlist[index]
                    : searchResults[index];
                return Center(
                child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    Detailspage(imageurl: ad.imageurl, transmition: ad.transmition, milage: ad.milage, model: ad.model, registration: ad.registration, carname: ad.carname, company: ad.company, enginecapacity: ad.enginecapacity, city: ad.city, color: ad.color, assembly: ad.assembly, createdAt: ad.createdAt, contact: ad.contact, price: ad.price)
                    ));

                  },

                  child: Container(
                  width: 350.w,
                  decoration: BoxDecoration(
                  color: const Color(0xff1E1E1E),
                  borderRadius: BorderRadius.circular(21.r),
                  ),
                  child: Column(
                  children: [
                  ClipRRect(
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21.r),
                  topRight: Radius.circular(21.r),
                  ),
                  child: SizedBox(
                  width: 350.w,
                  height: 200.h,
                  child: ad.imageurl.isEmpty || ad.imageurl[0].isEmpty
                  ? Center(
                  child: Icon(Icons.image, color: Colors.grey),
                  )
            : Hero(
                    tag: ad.imageurl[0],
              child: Image.network(
                    ad.imageurl[0],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                    child: SpinKitCircle(
                    color: Colors.white,
                    size: 30.sp,
                    ),
                    );
                    },
                    errorBuilder: (context, error, stackTrace) {
                    return Center(
                    child: Icon(
                    Icons.broken_image,
                    size: 40.sp,
                    color: Colors.red,
                    ),
                    );
                    },
                    ),
            ),
                  ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 4.h),
                  child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                  "${ad.company} ${ad.carname}",
                  style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp,
                  color: const Color(0xFFF5F5F5),
                  ),
                  ),
                  ),
                  ),
                  Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 4.h),
                  child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                  "${ad.price}",
                  style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: const Color(0xFFF5F5F5),
                  ),
                  ),
                  ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(21.r),
                  ),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Icon(Icons.add_road_outlined, color: Colors.white, size: 16.sp),
                  Text(
                  "${ad.milage} Km",
                  style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: Colors.white,
                  ),
                  ),
                  ],
                  ),
                  ),
                  Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(21.r),
                  ),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Icon(Icons.color_lens, color: Colors.white, size: 16.sp),
                  Text(
                  ad.color.toUpperCase(),
                  style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: Colors.white,
                  ),
                  ),
                  ],
                  ),
                  ),
                  Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(21.r),
                  ),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Icon(Icons.speed, color: Colors.white, size: 16.sp),
                  Text(
                  "${ad.enginecapacity}cc",
                  style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: Colors.white,
                  ),
                  ),
                  ],
                  ),
                  ),
                  ],
                  ),
                  ),
                  SizedBox(height: 12.h),
                  ],
                  ),
                  ),
                ),
                ),
                );
                },
                ),
          ),
    ),
    ),
    ],
    ),
    )
    );
  }
  }
