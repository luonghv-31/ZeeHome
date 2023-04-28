import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/screens/payment/paymentMethod/bankingScreen.dart';
import 'package:zeehome/screens/payment/paymentMethod/vnpayScreen.dart';
import 'package:zeehome/utils/constants.dart';

class PaymentScreen extends StatelessWidget {

  PaymentScreen({Key? key}) : super(key: key);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color.fromARGB(255, 255, 136, 175),
    primary: Colors.white,
    minimumSize: const Size(52, 52),
    maximumSize: const Size(52, 52),
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
                      children: <Widget>[

                        Container(
                          margin: const EdgeInsets.only(top: 46.0, left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userProvider.firstName} ${userProvider.lastName}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              Text(
                                userProvider.email,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
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
                            borderRadius: const BorderRadius.all( Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.white,
                              width: 4.0,
                            ),
                          ),
                        ),
                        // Image.asset("assets/logo.png")
                      ],
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
                                  Text('Số dư: '),
                                  Text(userProvider.balance.toString()),
                                ],
                              )
                          ),
                          Image.asset('assets/icon/money-bag.png'),
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
                  Text('Chọn phương thức nạp tiền'),
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
                                    Navigator.of(context).push(scaleInTransition(const BankingScreen()));
                                  },
                                  child: const Icon(
                                    Icons.savings,
                                    color: Colors.pink,
                                    size: 24,
                                    semanticLabel: 'Text to announce in accessibility modes',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('Banking', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
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
                                    Navigator.of(context).push(scaleInTransition(const VnpayScreen()));
                                  },
                                  child: const Icon(
                                    color: Colors.pink,
                                    size: 24,
                                    semanticLabel: 'Text to announce in accessibility modes',
                                    Icons.account_balance_wallet,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('VN Pay', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 72, 230), fontWeight: FontWeight.w600)),
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
