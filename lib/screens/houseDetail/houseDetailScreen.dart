import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/user/get_user_by_id_request.dart';
import 'package:zeehome/screens/chat/Widgets/chatDetailPage.dart';
import 'package:zeehome/screens/home/homeScreen.dart';
import 'package:zeehome/screens/houseDetail/component/followButton.dart';
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
              Flexible(
                child: Container(
                  child: Text(
                    houseDetail.title.toString()!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
                  ),
                ),
              ),
              // Text(houseDetail.title.toString()!, overflow: TextOverflow.fade, softWrap: false, maxLines: 1 , style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.black),)
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  child: Text(
                    houseDetail.address.toString()!,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    softWrap: false,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ),
              ),
              // Text(houseDetail.address.toString()!, overflow: TextOverflow.fade, softWrap: false, maxLines: 1, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildContact(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
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
                    backgroundImage: NetworkImage(houseDetail!.owner!.userImage!),
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
                              Icon(
                                Icons.done,
                                size: 18,
                                color: Color.fromARGB(255, 5, 94, 22),
                              ),
                              SizedBox(width: 4,),
                              Text('Uy tín', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 5, 94, 22))),
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
              FollowButton(houseDetail: houseDetail, userId: userProvider.userId),
              const SizedBox(height: 8,),
              ElevatedButton.icon(
                onPressed: () {
                  //  for testing let call the functon white press
                  SharedPreferences.getInstance().then((prefs) {
                    String access_token = prefs.get('access_token') as String;
                    if (houseDetail.owner?.userId != null && userProvider.userId != houseDetail.owner?.userId) {
                      GetUserByIdRequest.fetchUser(access_token, houseDetail.owner!.userId.toString()).then((value) => {
                        Navigator.of(context).push(scaleInTransition(ChatDetailPage(chatUser: value))),
                      });
                    }
                  });
                },
                icon: const Icon(
                  Icons.near_me,
                  color: secondaryColor40LightTheme,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                label: const Text("Gửi tin nhắn"),
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
    });
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
                        color: const Color.fromARGB(255, 130, 130, 130),
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
                        color: const Color.fromARGB(255, 84, 9, 205),
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

  Widget buildDesctription() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Mô tả', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)),
          const SizedBox(height: 6),
          Text(houseDetail.description!.toString()),
        ],
      ),
    );
  }

  Widget buildArround() {
    return Container(
      color: Colors.white,
    );
  }

  List<Widget> buildSlide() {
    if (houseDetail.images != null && houseDetail.images!.isNotEmpty) {
      return [...?houseDetail.images?.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black26,
                image: DecorationImage(
                  image: NetworkImage(i.toString()),
                  fit: BoxFit.fill,
                ),
                // shape: BoxShape.circle,
              ),
            );
          },
        );
      }).toList(),
        Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black26,
                image: DecorationImage(
                  image: NetworkImage(houseDetail.thumbnail.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        )
      ];
    } else if (houseDetail.thumbnail != null && houseDetail.thumbnail != 'null') {
      return [Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: NetworkImage(houseDetail.thumbnail.toString()),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      )];
    }
    return [Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(20.0),
            image: const DecorationImage(
              image: AssetImage(
                  'assets/images/background2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    )];
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
    return DefaultTextStyle(style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CarouselSlider(
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              height: 300,
                              aspectRatio: 16/9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: buildSlide(),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
                            child: Column(
                              children: [
                                const SizedBox(height: 40),
                                buildTitle(),
                                buildContact(context),
                                buildDesctription(),
                                buildFeature(),
                                buildArround(),
                                NearBySchoolComponent(location: '${houseDetail.latitude},${houseDetail.longitude}'),
                              ],
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 300 - 27),
                          width: 320,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 30,
                                color: kPrimaryColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${houseDetail.price} vnd', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
            Align(
              alignment: AlignmentDirectional.topStart, // <-- SEE HERE
              child: Container(
                height: 130,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                color: Colors.transparent,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: secondaryColor10LightTheme,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.keyboard_backspace,
                            color: secondaryColor40LightTheme,
                            size: 24.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          )
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: secondaryColor10LightTheme,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(scaleInTransition(const HomeScreen()));
                          },
                          icon: const Icon(
                            Icons.home,
                            color: secondaryColor40LightTheme,
                            size: 24.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        )

    );
  }
}

