import 'package:flutter/material.dart';
import 'package:sync/services/auth/auth_service.dart';
import 'package:sync/services/chat/chat_service.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
      HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService authService = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text("Home"),
        centerTitle: true,
      ),
      body: _buildUserList(),
   
    );
     
  }

  Widget _buildUserList (){
    return StreamBuilder(
      stream: _chatService.getUSerStream(),
       builder: (context, snapshot) {

         if(snapshot.hasError){
          return const Text("Eror");
         }
         
         if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
         }

         return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData,context)).toList(),
         );

       },);
  }

  Widget _buildUserListItem(Map<String, dynamic> userData,BuildContext context){

   if(userData["email"] != authService.getCurrentUser()!.email){

     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: UserTile(
         text: userData["email"],
         onTap: () => Navigator.push(
          context,
           MaterialPageRoute(
            builder: (context) => ChatPage(
              reciverEmail: userData["email"],
              reciverID: userData["uid"],),)),
         ),
     );

   }else{
    return Container();
   }

       

  }
}