import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/utils/constants.dart';

class HouseItem extends StatelessWidget {
  final House itemInfo;
  HouseItem({Key? key, required this.itemInfo}) : super(key: key);
  final f = DateFormat('dd-MM-yyyy');
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 40,
            color: Colors.deepPurpleAccent.withOpacity(0.4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemInfo.title!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
              const SizedBox(height: 4,),
              Text('${itemInfo.price.toString()!} vnd', style: const TextStyle(fontSize: 16))
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(f.format(inputFormat.parse(itemInfo.createdDate.toString()))),
            ],
          )
        ],
      ),
    );
  }
}
