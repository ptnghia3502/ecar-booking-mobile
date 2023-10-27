import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentImageIndex = 0;
  final List<String> bannerImages = [
    'lib/assets/images/banner_01.jpg',
    'lib/assets/images/banner_02.jpg',
    'lib/assets/images/banner_03.jpg',
    'lib/assets/images/banner_04.jpg',
  ];

  final List<String> voucherImages = [
    'lib/assets/images/vouchers/voucher_01.jpg',
    'lib/assets/images/vouchers/voucher_02.jpg',
    'lib/assets/images/vouchers/voucher_03.jpg',
    'lib/assets/images/vouchers/voucher_04.jpg',
    'lib/assets/images/vouchers/voucher_05.jpg',
    'lib/assets/images/vouchers/voucher_06.jpg',
    'lib/assets/images/vouchers/voucher_07.jpg',
    'lib/assets/images/vouchers/voucher_08.jpg',
    'lib/assets/images/vouchers/voucher_09.jpg',
    'lib/assets/images/vouchers/voucher_10.jpg',
  ];

  final List<String> voucherTitles = [
    'The Beverly Solari',
    'Voucher Vinfast',
    'Glory Heights',
    'Booking Beverly',
    'Sale Penhouse Solari',
    'Grand Park Grill Party',
    'Vinhomes Priority',
    'No Limit Sale',
    'Best Place To Life',
    'All in Money',
  ];

  // Function to show a dialog with the full image
  void _showFullImage(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context)
                .size
                .width, // Set width to fit the screen
            height: 300,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain, // Fit the image within the Container
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 250,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 10),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
                items: bannerImages.map((imagePath) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        imagePath,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerImages.map((image) {
                int index = bannerImages.indexOf(image);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index
                        ? Colors.orangeAccent
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'New Voucher',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
            SizedBox(
              height: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: voucherImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _showFullImage(voucherImages[index]);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            voucherImages[index],
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        voucherTitles[index], // Display the corresponding title
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
