import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/user/user_request.dart';
import 'package:zeehome/screens/payment/paymentMethod/bankingScreen.dart';
import 'package:zeehome/screens/payment/paymentMethod/vnpayScreen.dart';
import 'package:zeehome/utils/constants.dart';

class PaymentScreen extends StatelessWidget {

  PaymentScreen({Key? key}) : super(key: key);

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


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(builder: (context, userProvider, child){
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.25,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: 36 + kDefaultPadding,
                    ),
                    height: size.height * 0.25 - 27,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background_app.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 255, 255, 255),
                          BlendMode.dstATop,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 40.0),
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(0, 255, 255, 255),
                            image: DecorationImage(
                              image: NetworkImage(userProvider.image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          margin: const EdgeInsets.only(top: 48.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userProvider.firstName} ${userProvider.lastName}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              Text(
                                userProvider.email,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        // Image.asset("assets/logo.png")
                      ],
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 12,
                    child: CircleAvatar(
                        backgroundColor: secondaryColor10LightTheme,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: secondaryColor40LightTheme,
                            size: 24.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                        )
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Row(
                                children: [
                                  const Text('Số dư: '),
                                  Text((userProvider.balance / 100).toString()),
                                ],
                              )
                          ),
                          IconButton(
                            onPressed: () {
                              SharedPreferences.getInstance().then((prefs) {
                                String access_token = prefs.get(
                                    'access_token') as String;
                                GetUserRequest.fetchUser(access_token).then((value) => {
                                  userProvider.updateBalance(value.balance),
                                });
                              });
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.black54,
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.only(left: 16, right: 16),
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
                                      Navigator.of(context).push(scaleInTransition(BankingScreen()));
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Banking', style: TextStyle(color: Colors.black, fontSize: 20)),
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
                                                    image: AssetImage('assets/images/banking.png'),
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
                                      Navigator.of(context).push(scaleInTransition(const VnpayScreen()));
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('VNPay', style: TextStyle(color: Colors.black, fontSize: 20)),
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
                                                    image: AssetImage('assets/images/vnpay.png'),
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
            ),
          ],
        ),
      );
    });
  }
}
