import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
final void Function()? onTap;
  const UserTile({
    super.key,
    required this.onTap,
    required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12)
      ),

      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          children: [
            Icon(Icons.person,
            size: 40,),

            SizedBox(width: 15,),
        
            Text(text,
            style: TextStyle(
              fontSize: 15
            ),)
          ],
        ),
      ),
    ),
    );
  }
}