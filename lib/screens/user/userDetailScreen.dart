import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/screens/user/components/detail.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(builder: (context, userProvider, child){
      return Scaffold(
        body: DefaultTextStyle(style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                UserDetail(user: userProvider.getUserObj(), size: size),
              ],
            ),
          ),
        ),
      );
    });
  }
}
