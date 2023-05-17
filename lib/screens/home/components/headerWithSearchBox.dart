import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/screens/search/locationSearchScreen.dart';
import 'package:zeehome/utils/constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return  Container(
        margin: const EdgeInsets.only(bottom: kDefaultPadding - 16),
        // It will cover 20% of our total height
        height: size.height * 0.32,
        child: Stack(
          children: <Widget>[
            Container (
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 30 + kDefaultPadding,
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
                  Container(
                    margin: const EdgeInsets.only(top: 46.0, left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.name,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        Text(
                          userProvider.email,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
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
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(400, 120),
                    maximumSize: const Size(400, 120),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(scaleInTransition( const  SearchLocationScreen()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Tìm kiếm', style: TextStyle(color: Colors.black, fontSize: 20)),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            width: 68,
                            height: 68,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/search.png'),
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
            ),
          ],
        ),
      );
    });
  }
}
