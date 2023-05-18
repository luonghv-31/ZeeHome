import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/chat/chatModel.dart';
import 'package:zeehome/screens/createHouse/createHouseScreen.dart';
import 'package:zeehome/screens/houseList/houseListScreen.dart';
import 'package:zeehome/screens/payment/paymentScreen.dart';
import 'package:zeehome/screens/user/userDetailScreen.dart';
import 'package:zeehome/utils/constants.dart';
import 'package:zeehome/screens/chat/chatScreen.dart';
class Features extends StatefulWidget {

  final Size size;
  Features({Key? key, required this.size}) : super(key: key);

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
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

  // ChatModel chatModel = ChatModel();

  @override void initState() {
    // TODO: implement initState
    debugPrint('check run');
    SharedPreferences.getInstance().then((prefs) {
      String access_token = prefs.get('access_token') as String;
      Provider.of<ChatModel>(context, listen: false).init(access_token);
    });
    super.initState();
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
                              Navigator.of(context).push(scaleInTransition(PaymentScreen()));
                            },
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
                              Navigator.of(context).push(scaleInTransition(const UserDetailScreen()));
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
                            Navigator.of(context).push(scaleInTransition(const HouseListScreen()));
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
                              Navigator.of(context).push(scaleInTransition(const CreateHouseScreen()));
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
                            style: raisedButtonStyle,
                            onPressed: () {
                              Navigator.of(context).push(scaleInTransition( ChatScreen()));
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
                        ),
                      ),
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

