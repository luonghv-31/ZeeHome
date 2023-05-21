import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/screens/following/components/followingList.dart';
import 'package:zeehome/screens/houseList/components/houseList.dart';
import 'package:zeehome/utils/constants.dart';

class FollowingListScreen extends StatelessWidget {
  const FollowingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider ,child){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
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
          title: const Text(
            "Danh sách theo dõi",
            style: TextStyle(color: textColorLightTheme),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: FollowingList(),
        ),
      );
    });
  }
}
