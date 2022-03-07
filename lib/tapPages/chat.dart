import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Align(
     alignment: AlignmentDirectional(0.85, 0.9),
     child: IconButton(
              onPressed: () async{
              await FlutterPhoneDirectCaller.callNumber("+966538456777");
                
              },
              icon:Icon(Icons.phone), 
              iconSize: 33,
           
              
          
              ),
              
            
    );
  }
}
