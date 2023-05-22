import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/network/user/get_user_by_id_request.dart';
import 'package:zeehome/screens/chat/Widgets/chatDetailPage.dart';
import 'package:intl/intl.dart';

class ConversationList extends StatefulWidget {
  String userId;
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;

  ConversationList(
      {required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead,
      required this.userId});

  @override
  _ConversationListState createState() => _ConversationListState();
}
ScrollController _scrollController1 = new ScrollController();


class _ConversationListState extends State<ConversationList> {
  String dateTime(createAt) {
    DateTime receiveTime = DateTime.parse(createAt);
    DateTime add_GMT7 = receiveTime.add(Duration(hours: 7));
    String formattedTime = DateFormat("HH:mm dd/MM").format(add_GMT7);
    return formattedTime;
  }

  

 @override
  void dispose() {
    
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController1,
      physics: NeverScrollableScrollPhysics(),
      
  child: TextButton(    
    
    onPressed: () {
     
      SharedPreferences.getInstance().then((prefs) {
        String access_token = prefs.get('access_token') as String;
        GetUserByIdRequest.fetchUser(access_token, widget.userId)
            .then((value) => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return ChatDetailPage(
                      chatUser: value,
                    );
                  }))
                });
      });
    },
    child: Container(
      padding:
          const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                  maxRadius: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.messageText,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: widget.isMessageRead
                                  ? FontWeight.w900
                                  : FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            dateTime(widget.time),
            style: TextStyle(
              color: Colors.black,
                fontSize: 12,
                fontWeight: widget.isMessageRead
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
        ],
      ),
    ),
  ),
);
  }
}
