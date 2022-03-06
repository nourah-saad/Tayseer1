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
    return Center(
     child: ElevatedButton(
              onPressed: () async{
              await FlutterPhoneDirectCaller.callNumber("+966538456777");
                
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFD8EBEE),
              ),
              child: const Text(
                "اتصل بنا",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
            ),
    );
  }
}
