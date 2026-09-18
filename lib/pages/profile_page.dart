
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sync/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,


      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: Column(
        children: [

            SizedBox(height: 10,),

         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

             SizedBox(width: 20,),

             Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.person,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 100,),
            ),
          ),

          SizedBox(width: 10,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_authService.getCurrentUser()!.email.toString(),
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize:30
              ),),
            ),
          ),
          ],
         ),

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    Text("Dark Mode",
                    style: TextStyle(
                      fontSize: 15
                    ),),
                
                    CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                       onChanged: (value) => Provider.of<ThemeProvider>(
                        context, listen: false).toggleThemes(),)
                
                  ],
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: _authService.signOut,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.secondary
            
              ),
              child: Padding(
                padding: const EdgeInsets.all(23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout",
                    style: TextStyle(
                      fontSize: 15
                    ),),
                
                    Icon(Icons.logout,
                    color: Colors.redAccent,)
                
                  ],
                ),
              ),
            ),
          )


        ],
      ),
    );
  }
}