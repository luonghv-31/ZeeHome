import 'package:flutter/material.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zeehome/screens/houseDetail/component/nearBySchool.dart';
import 'package:zeehome/utils/constants.dart';

class HouseDetailScreen extends StatelessWidget {
  final House houseDetail;
  final CarouselController buttonCarouselController = CarouselController();

  HouseDetailScreen({Key? key, required this.houseDetail}) : super(key: key);

  Widget buildTitle() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(houseDetail.title.toString()!, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.black),)
            ],
          ),
          Row(
            children: [
              Text(houseDetail.address.toString()!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black)),
            ],
          ),
          Row(
            children: [
              Text('${houseDetail.price.toString()!} vnd', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black)),
            ],
          )
        ],
      ),
    );
  }

  Widget buildContact() {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Liên hệ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  radius: 32,
                  child: Text('AH'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(houseDetail.owner!.email.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('yes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
                            Text('Uy tín', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
                          ],
                        ),
                        const Text('---------------', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                      ],
                    ),
                    Text(houseDetail.owner!.phoneNumber.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                //  for testing let call the functon white press
              },
              icon: const Icon(
                Icons.near_me,
                color: secondaryColor40LightTheme,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              label: const Text("Liên hệ"),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor10LightTheme,
                foregroundColor: textColorLightTheme,
                elevation: 0,
                fixedSize: const Size(double.infinity, 30),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget buildFeature() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tiện ích', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)),
          const SizedBox(height: 8),
          Column(
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.ac_unit,
                    color: Color.fromARGB(255, 0, 106, 255),
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  SizedBox(width: 8),
                  Text('Điều hòa')
                ],
              ),
              Row(
                children: const [
                  Icon(
                    Icons.local_parking,
                    color: Color.fromARGB(255, 0, 106, 255),
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  SizedBox(width: 8),
                  Text('Bãi gửi xe')
                ],
              ),
              Row(
                children: const [
                  Icon(
                    Icons.elevator,
                    color: Color.fromARGB(255, 0, 106, 255),
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  SizedBox(width: 8),
                  Text('Thang máy')
                ],
              ),
              Row(
                children: const [
                  Icon(
                    Icons.pets,
                    color: Color.fromARGB(255, 0, 106, 255),
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  SizedBox(width: 8),
                  Text('Thú nuôi')
                ],

              ),
              Row(
                children: const [
                  Icon(
                    Icons.chair,
                    color: Color.fromARGB(255, 0, 106, 255),
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  SizedBox(width: 8),
                  Text('Thiết bị')
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Không gian', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 20.0,
                      minWidth: 40.0,
                      maxHeight: 100.0,
                      maxWidth: 100.0,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 107, 200),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                          child: (
                              Text('Phòng: ${houseDetail.rooms != null ? houseDetail.rooms.toString() : '0'}', style: const TextStyle( fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white ))
                          )
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 8),
              Container(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 20.0,
                      minWidth: 40.0,
                      maxHeight: 100.0,
                      maxWidth: 200.0,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 41, 124, 27),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                          child: (
                              Text('Phòng ngủ: ${houseDetail.bedRooms != null ? houseDetail.bedRooms.toString() : '0'}', style: const TextStyle( fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white ))
                          )
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 8),
              Container(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 20.0,
                      minWidth: 40.0,
                      maxHeight: 100.0,
                      maxWidth: 200.0,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 130, 130, 130),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                          child: (
                              Text('Phòng tắm: ${houseDetail.bathRooms != null ? houseDetail.bathRooms.toString() : '0'}', style: const TextStyle( fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white ))

                          )
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 8),
              Container(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 20.0,
                      minWidth: 40.0,
                      maxHeight: 100.0,
                      maxWidth: 200.0,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 84, 9, 205),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                          child: (
                              Text('Phụ thu: ${houseDetail.maintenanceFee != null ? houseDetail.maintenanceFee.toString() : '0'}', style: const TextStyle( fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white ))
                          )
                      ),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildArround() {
    return Container(
      color: Colors.white,
    );
  }

  Widget buildSchoolNearBy() {
    return Container(
        color: Colors.white,
        child: (
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Trường học xung quanh'),
              ],
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTextStyle(style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        child:
        SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 300,
                      aspectRatio: 16/9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: houseDetail.images != null ? houseDetail.images?.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/background2.jpg'),
                                fit: BoxFit.fill,
                              ),
                              // shape: BoxShape.circle,
                            ),
                          );
                        },
                      );
                    }).toList() : [
                      Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 2.0),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background2.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: const Text('text ssfsdf', style: const TextStyle(fontSize: 16.0))
                          );
                        },
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
                    child: Column(
                      children: [
                        buildTitle(),
                        buildContact(),
                        buildFeature(),
                        buildArround(),
                        NearBySchoolComponent(location: '${houseDetail.latitude},${houseDetail.longitude}'),
                      ],
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}

