import 'package:flutter/material.dart';
import 'package:sync/services/auth/auth_service.dart';
import 'package:sync/components/my_button.dart';
import 'package:sync/components/my_textfield.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap
    });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController pwController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

    bool isLoading = false;

  void login(BuildContext context) async {

    final authService = AuthService();

    setState(() {
      isLoading = true;
    });


    try{
      await authService.signInWithEmailAndPassword(emailController.text, pwController.text); 
       
    } catch (e){
     // ignore: use_build_context_synchronously
     showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(e.toString()),
     ),);

     setState(() {
       isLoading = false;
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body:

      isLoading?

      Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ):

       Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              height: 170,
              child: Image.asset("assets/icon.png",
              ),
            ),
        
           
            SizedBox(height: 15,),

            Text("Welcome back, you've been missed!",
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.inversePrimary),),
            
              SizedBox(height: 25,),

              MyTextfield(
                isPasswordField: false,
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),

                SizedBox(height: 25,),

              MyTextfield(
                isPasswordField: true,
                hintText: "Password",
                obscureText: true,
                controller: pwController,
                ),

                SizedBox(height: 25,),

              MyButton(
                text: "Login",
                onTap: () => login(context),
              ),

              SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                  ),
                   
                   SizedBox(width: 5,),
               
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Register Now",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade300
                    ),),
                  ),

                ],
              )
        
          ],
        ),
      ),
    );
  }
}