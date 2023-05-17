import 'package:flutter/material.dart';
import 'package:zeehome/screens/createHouse/createHouseScreen.dart';
import 'package:zeehome/screens/houseList/houseListScreen.dart';
import 'package:zeehome/screens/map/mapScreen.dart';
import 'package:zeehome/screens/payment/paymentScreen.dart';
import 'package:zeehome/screens/search/locationSearchScreen.dart';
import 'package:zeehome/screens/user/userDetailScreen.dart';
<<<<<<< HEAD
import 'package:zeehome/utils/constants.dart';
=======
import 'package:zeehome/screens/chat/chatScreen.dart';
>>>>>>> 4c5f3de79d64d2aad261001899837538aa8fbee9

class Features extends StatelessWidget {
  Features({
    Key? key,
    required this.size,
  }) : super(key: key);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color.fromARGB(255, 255, 136, 175),
    primary: Colors.white,
    minimumSize: const Size(176, 132),
    maximumSize: const Size(176, 132),
    // padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          GridView.count(
              shrinkWrap: true,
              childAspectRatio: (1 / .76),
              crossAxisCount: 2,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: kPrimaryColor.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn(PaymentScreen()));
                          },
<<<<<<< HEAD
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Thanh toán', style: TextStyle(color: Colors.black, fontSize: 20)),
                              const SizedBox(height: 16,),
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    width: 68,
                                    height: 68,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/payment.png'),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
=======
                          child: const Icon(
                            color: Colors.pink,
                            size: 24,
                            semanticLabel: 'Text to announce in accessibility modes',
                            Icons.attach_money_outlined,
                          ),
>>>>>>> 4c5f3de79d64d2aad261001899837538aa8fbee9
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: kPrimaryColor.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn(const UserDetailScreen()));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Tài khoản', style: TextStyle(color: Colors.black, fontSize: 20)),
                              const SizedBox(height: 16,),
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    width: 68,
                                    height: 68,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/user.png'),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: kPrimaryColor.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn(const HouseListScreen()));
                          },
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Bài đăng', style: TextStyle(color: Colors.black, fontSize: 20)),
                              const SizedBox(height: 16,),
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    width: 68,
                                    height: 68,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/houseList.png'),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: kPrimaryColor.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.of(context).push(scaleIn(const CreateHouseScreen()));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Tạo bài đăng', style: TextStyle(color: Colors.black, fontSize: 20)),
                              const SizedBox(height: 16,),
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    width: 68,
                                    height: 68,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/createHouse.png'),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: kPrimaryColor.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
<<<<<<< HEAD
                            style: raisedButtonStyle,
                            onPressed: () {
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Trò chuyện', style: TextStyle(color: Colors.black, fontSize: 20)),
                                const SizedBox(height: 16,),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Container(
                                      width: 68,
                                      height: 68,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/chat.png'),
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
=======
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
>>>>>>> 4c5f3de79d64d2aad261001899837538aa8fbee9
                        ),
                      ),
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