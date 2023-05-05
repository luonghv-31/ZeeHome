import 'package:flutter/material.dart';
import 'package:zeehome/screens/createHouse/createHouseScreen.dart';
import 'package:zeehome/screens/map/mapScreen.dart';
import 'package:zeehome/screens/payment/paymentScreen.dart';
import 'package:zeehome/screens/search/locationSearchScreen.dart';
import 'package:zeehome/screens/user/userDetailScreen.dart';
import 'package:zeehome/screens/chat/chatScreen.dart';

class Features extends StatelessWidget {
  Features({
    Key? key,
    required this.size,
  }) : super(key: key);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color.fromARGB(255, 255, 136, 175),
    primary: Colors.white,
    minimumSize: const Size(52, 52),
    maximumSize: const Size(52, 52),
    // padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
  );

  final Size size;

  Route scaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.9;
        var end = 1.0;
        var curve = Curves.easeInOutBack;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var tween2 = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));


        return ScaleTransition(
          scale: animation.drive(tween),
          child: FadeTransition(
            opacity: animation.drive(tween2),
            child: page,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      // color: const Color.fromARGB(255, 242, 242, 242),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          GridView.count(
              shrinkWrap: true,
              childAspectRatio: (1 / 1.1),
              crossAxisCount: 4,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn(const MapScreen()));
                          },
                          child: const Icon(
                            Icons.maps_home_work_outlined,
                            color: Colors.pink,
                            size: 24,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Bản đồ', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn(PaymentScreen()));
                          },
                          child: const Icon(
                            color: Colors.pink,
                            size: 24,
                            semanticLabel: 'Text to announce in accessibility modes',
                            Icons.attach_money_outlined,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Nạp tiền', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn(const UserDetailScreen()));
                          },
                          child: const Icon(
                            color: Colors.pink,
                            size: 24,
                            semanticLabel: 'Text to announce in accessibility modes',
                            Icons.account_circle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Tài khoản', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () { },
                          child: const Icon(
                            color: Colors.pink,
                            size: 24,
                            semanticLabel: 'Text to announce in accessibility modes',
                            Icons.fact_check,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Bài viết', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn(const CreateHouseScreen()));
                          },
                          child: const Icon(
                            color: Colors.pink,
                            size: 24,
                            semanticLabel: 'Text to announce in accessibility modes',
                            Icons.library_add,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Tạo bài viết', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn( const  SearchLocationScreen()));
                          },
                          child: const Icon(
                            color: Colors.pink,
                            size: 24,
                            semanticLabel: 'Text to announce in accessibility modes',
                            Icons.search,
                          ),
                        ),

                      ),
                      const SizedBox(height: 10),
                      const Text('Tìm kiếm', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn( ChatScreen()));
                          },
                          child: const Icon(
                            color: Colors.pink,
                            size: 24,
                            semanticLabel: 'Text to announce in accessibility modes',
                            Icons.message_outlined,
                          ),
                        ),

                      ),
                      const SizedBox(height: 10),
                      const Text('Tin nhắn', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ]
            )
        ],
      ),
    );
  }
}
