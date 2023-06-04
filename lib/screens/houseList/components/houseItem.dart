import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/houseProvider.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/network/house/delete_house_request.dart';
import 'package:zeehome/network/house/house_detail_request.dart';
import 'package:zeehome/screens/editHouse/editHouseScreen.dart';
import 'package:zeehome/screens/houseDetail/houseDetailScreen.dart';
import 'package:zeehome/utils/constants.dart';

class HouseItem extends StatelessWidget {
  final House itemInfo;
  Function() refreshCallBack;
  HouseItem({Key? key, required this.itemInfo, required this.refreshCallBack}) : super(key: key);
  final f = DateFormat('dd-MM-yyyy');
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color.fromARGB(255, 255, 136, 175),
    primary: Colors.white,
    padding: const EdgeInsets.only(bottom: 20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 32),
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
            onPressed: () {
              if (itemInfo.houseId != null) {
                GetHouseDetailRequest.fetchHouseDetail(itemInfo.houseId.toString()).then((value) => {
                  Navigator.of(context).push(scaleInTransition((HouseDetailScreen(houseDetail: value)))),
                });
              }
            },
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    color: Colors.black26,
                    image: DecorationImage(
                      image: NetworkImage(itemInfo.thumbnail!),
                      fit: BoxFit.cover,
                    ),
                    // shape: BoxShape.circle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  itemInfo.title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          // Text(itemInfo.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),),
                          const SizedBox(height: 12,),
                          Text('${itemInfo.price.toString()!} vnd', style: const TextStyle(fontSize: 16, color: Colors.black54))
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(f.format(inputFormat.parse(itemInfo.createdDate.toString())), style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 200,
            right: 0,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      if (itemInfo.houseId != null) {
                        GetHouseDetailRequest.fetchHouseDetail(itemInfo.houseId!).then((value) => {
                          Provider.of<HouseProvider>(context, listen: false).setInfo(value, itemInfo.houseId.toString()),
                          Navigator.of(context).push(scaleInTransition((const EditHouseScreen()))),
                        });
                      }
                    },
                    icon: const Icon(Icons.edit_note, color: Colors.black54,),
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child:  IconButton(
                    onPressed: () {
                      if (itemInfo.houseId != null) {
                        SharedPreferences.getInstance().then((prefs) {
                          String access_token = prefs.get('access_token') as String;
                          DeleteHouseRequest.fetchDeleteHouse(access_token, itemInfo.houseId.toString());
                        }).then((value){
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Thông báo'),
                              content: const Text('Xóa bài đăng thành công!'),
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
                    icon: const Icon(Icons.delete, color: Colors.black54,),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
