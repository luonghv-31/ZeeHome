import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/user/delete_follow_request.dart';
import 'package:zeehome/network/user/follow_request.dart';
import 'package:zeehome/network/user/get_follow_request.dart';
import 'package:zeehome/network/user/get_user_by_id_request.dart';
import 'package:zeehome/utils/constants.dart';

class FollowButton extends StatefulWidget {
  final House houseDetail;
  final String userId;

  const FollowButton({Key? key, required this.houseDetail, required this.userId}) : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollow = false;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.houseDetail.owner?.userId != null) {
      SharedPreferences.getInstance().then((prefs) {
        String access_token = prefs.get('access_token') as String;
        GetFollowRequest.fetchFollowRequest(access_token, widget.houseDetail.owner!.userId.toString()).then((value){
          setState(() {
            isFollow = value;
          });
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isFollow == true ? ElevatedButton.icon(
        onPressed: () {
          //  for testing let call the functon white press
          SharedPreferences.getInstance().then((prefs) {
            String access_token = prefs.get('access_token') as String;
            if (widget.houseDetail.owner?.userId != null && widget.userId != widget.houseDetail.owner?.userId) {
              SharedPreferences.getInstance().then((prefs) {
                String access_token = prefs.get('access_token') as String;
                DeleteFollowRequest.fetchDeleteFollowRequest(access_token, widget.houseDetail.owner!.userId.toString()).then((value) {
                  if (value) {
                    setState(() {
                      isFollow = false;
                    });
                  }
                }).catchError((error) {
                  setState(() {
                    isFollow = false;
                  });
                });
              });
            }
          });
        },
        icon: const Icon(
          Icons.add,
          color: secondaryColor40LightTheme,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        label: const Text("Bỏ theo dõi"),
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor10LightTheme,
          foregroundColor: textColorLightTheme,
          elevation: 0,
          fixedSize: const Size(double.infinity, 30),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ) : ElevatedButton.icon(
        onPressed: () {
          //  for testing let call the functon white press
          if (widget.houseDetail.owner?.userId != null && widget.userId != widget.houseDetail.owner?.userId) {
            SharedPreferences.getInstance().then((prefs) {
              String access_token = prefs.get('access_token') as String;
              FollowRequest.fetchFollowRequest(access_token, widget.houseDetail.owner!.userId.toString()).then((value) {
                if (value) {
                  setState(() {
                    isFollow = true;
                  });
                }
              });
            });
          }
        },
        icon: const Icon(
          Icons.add,
          color: secondaryColor40LightTheme,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        label: const Text("Theo dõi"),
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor10LightTheme,
          foregroundColor: textColorLightTheme,
          elevation: 0,
          fixedSize: const Size(double.infinity, 30),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
