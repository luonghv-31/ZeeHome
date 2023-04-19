import 'package:flutter/material.dart';
import 'package:zeehome/utils/constants.dart';

class UserHouseList extends StatefulWidget {
  const UserHouseList({Key? key}) : super(key: key);

  @override
  State<UserHouseList> createState() => _UserHouseListState();
}

class _UserHouseListState extends State<UserHouseList> {
  @override
  Widget build(BuildContext context) {
    return Container (
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
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
            label: const Text("Xem các bài đăng của tôi"),
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor10LightTheme,
              foregroundColor: textColorLightTheme,
              elevation: 0,
              fixedSize: const Size(double.infinity, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
