import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/network/user/get_user_by_id_request.dart';
import 'package:zeehome/screens/chat/Widgets/chatDetailPage.dart';
class ConversationList extends StatefulWidget{
  String userId;
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;

  ConversationList({required this.name,required this.messageText,required this.imageUrl,required this.time,required this.isMessageRead, required this.userId});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: (){
       // Provider.of<ChatModel>(context, listen: false).getChatHistory(widget.userId);
       SharedPreferences.getInstance().then((prefs) {
         String access_token = prefs.get('access_token') as String;
         GetUserByIdRequest.fetchUser(access_token, widget.userId).then((value) => {
           Navigator.push(context, MaterialPageRoute(builder: (context){
            return ChatDetailPage(chatUser: value,);
           }))
         });
       });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          const SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}
