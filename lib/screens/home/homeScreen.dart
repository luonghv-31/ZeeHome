import 'package:flutter/material.dart';
import 'package:zeehome/components/bottomNavigation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeehome/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: buildAppBar(),
        body: HomeBody(),
      );
    }

    AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icon/menu.svg"),
        onPressed: () {},
      ),
    );
  }
}