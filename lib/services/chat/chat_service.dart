import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sync/models/message.dart';

class ChatService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUSerStream(){

    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        final user = doc.data();

        return user;
      }).toList();
    });

  }

  Future<void> sendMessage(String reciverID,message) async{
    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    
    Message newMessage = Message(
       message: message,
       reciverID:reciverID, 
       senderEmail: currentUserEmail, 
       senderID: currentUserID, 
       timestamp:  timestamp);

       List<String> ids = [currentUserID,reciverID];
       ids.sort();
       String chatRoomID = ids.join('_');

       await _firestore
       .collection("chatrooms")
       .doc(chatRoomID)
       .collection("messages")
       .add(newMessage.toMap());

    
  }

     Stream<QuerySnapshot> getMessages (String userID,otherUserID){
        List<String> id = [userID,otherUserID];
        id.sort();
        String chatRoomID = id.join('_');

        return _firestore
        .collection("chatrooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp",descending: false)
        .snapshots();
       }




}