import 'package:flutter/material.dart';
import 'package:zeehome/screens/map/mapScreen.dart';
import 'package:zeehome/screens/search/locationSearchScreen.dart';

class Features extends StatelessWidget {
  Features({
    Key? key,
    required this.size,
  }) : super(key: key);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color.fromARGB(255, 255, 136, 175),
    primary: Colors.white,
    minimumSize: const Size(80, 80),
    maximumSize: const Size(80, 80),
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
      padding: const EdgeInsets.only(left: 25, right: 25),
      // color: const Color.fromARGB(255, 242, 242, 242),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          const Text('Tính năng', style: TextStyle(color: Color.fromARGB(255, 7, 23, 79), fontSize: 18, fontWeight: FontWeight.w600)),
          GridView.count(
              shrinkWrap: true,
              childAspectRatio: (1 / 1.1),
              crossAxisCount: 3,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
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
                      const SizedBox(height: 10),
                      const Text('Bản đồ', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () { },
                        child: const Icon(
                          color: Colors.pink,
                          size: 24,
                          semanticLabel: 'Text to announce in accessibility modes',
                          Icons.maps_home_work_outlined,
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
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () { },
                        child: const Icon(
                          color: Colors.pink,
                          size: 24,
                          semanticLabel: 'Text to announce in accessibility modes',
                          Icons.account_circle,
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
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () { },
                        child: const Icon(
                          color: Colors.pink,
                          size: 24,
                          semanticLabel: 'Text to announce in accessibility modes',
                          Icons.fact_check,
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
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () { },
                        child: const Icon(
                          color: Colors.pink,
                          size: 24,
                          semanticLabel: 'Text to announce in accessibility modes',
                          Icons.library_add,
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
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.of(context).push(scaleIn( const  SearchLocationScreen()));
                        },
                        child: const Icon(
                          color: Colors.pink,
                          size: 24,
                          semanticLabel: 'Text to announce in accessibility modes',
                          Icons.library_add,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Tìm kiếm', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
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
