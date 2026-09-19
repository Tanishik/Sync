import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sync/pages/navigation_page.dart';
import 'package:sync/services/auth/login_or_register.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
           if(snapshot.hasData){
            return NavigationPage();
           }else{
            return LoginOrRegister();
           }
         },),
    );
  }
}