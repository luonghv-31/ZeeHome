import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/following.dart';
import 'package:zeehome/network/user/delete_follow_request.dart';
import 'package:zeehome/utils/constants.dart';

class UserItem extends StatelessWidget {
  final Users users;
  Function() refreshCallBack;

  UserItem({Key? key, required this.users, required this.refreshCallBack}) : super(key: key);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color.fromARGB(255, 255, 136, 175),
    primary: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
      // padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 16,
            color: Colors.deepPurpleAccent.withOpacity(0.2),
          ),
        ],
      ),
      child: Stack(
        children: [
          ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  radius: 32,
                  backgroundImage: NetworkImage(users.image!),
                ),
                const SizedBox(width: 12,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${users.firstName} ${users.lastName}', style: const TextStyle(color: Colors.black54, fontSize: 16),),
                    Text(users.email!, style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w300),)
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (users.userId != null) {
                        SharedPreferences.getInstance().then((prefs) {
                          String access_token = prefs.get('access_token') as String;
                          DeleteFollowRequest.fetchDeleteFollowRequest(access_token, users.userId!);
                        }).then((value){
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Thông báo'),
                              content: const Text('Bỏ theo dõi thành công!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    refreshCallBack();
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        });
                      }
                    },
                    icon: const Icon(Icons.close, color: Colors.black54,),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
