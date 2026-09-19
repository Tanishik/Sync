import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sync/components/chat_bubble.dart';
import 'package:sync/components/my_textfield.dart';
import 'package:sync/services/auth/auth_service.dart';
import 'package:sync/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String reciverEmail;
  final String reciverID;
   const ChatPage({super.key,
  required this.reciverEmail,
  required this.reciverID
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener((){
     if(_focusNode.hasFocus){
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          if (mounted) scrollDown();
        },
      );
     }
    });

    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (mounted) scrollDown();
      }
    );
  }
 
 void scrollDown(){
  if (_scrollController.hasClients) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300), 
      curve: Curves.fastOutSlowIn);
  }
 }
 

  void sendMessage () async{
    if(_messageController.text.isNotEmpty){

     await chatService.sendMessage(widget.reciverID, _messageController.text);
     _messageController.clear();

    }

    scrollDown();
     
  }

   @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.reciverEmail),
        backgroundColor:Colors.transparent,
        scrolledUnderElevation: 0,
      ),

      body: Column(
        children: [

          Expanded(child: buildMessageList()),

          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: buildUserInput(),
          )
        ],
      ),
    );
  }

  Widget buildMessageList(){
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatService.getMessages(widget.reciverID, senderID),
     builder: (context, snapshot) {
       
       if(snapshot.hasError){
        return const Center(child: Text("Error"));
       }

       if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: Text("Loading!"));
       }

       final docs = snapshot.data!.docs;

    
       WidgetsBinding.instance.addPostFrameCallback((_) {
         if (mounted && _scrollController.hasClients) {
           _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
         }
       });
        
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            overscroll: false
          ),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return buildMessageitem(docs[index]);
            },
          ),
        );

     },);

  }

  Widget buildMessageitem( DocumentSnapshot doc){

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == authService.getCurrentUser()!.uid;
    var alignment = isCurrentUser? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChatBubble(isCurrentUser: isCurrentUser, message: data["message"]),
      ));

  }

  Widget buildUserInput(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: MyTextfield(
            focusNode: _focusNode,
            isPasswordField: false,
            hintText: "Type a message", 
            obscureText: false, 
            controller: _messageController)),
      
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: IconButton(
                  onPressed: sendMessage,
                   icon: Icon(Icons.arrow_upward,
                   color: Colors.white,)),
              ),
            )
        ],
      ),
    );
  }
}