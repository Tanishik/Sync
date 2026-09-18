import 'package:flutter/material.dart';
import 'package:sync/services/auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap
    });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController pwController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

     bool isLoading = false;

   void register (BuildContext context){
    final auth = AuthService();
      
      setState(() {
        isLoading = true;
      });
    
    
    if(pwController.text == confirmPwController.text){
      try{
      auth.signUpWithEmailAndPassword(emailController.text, pwController.text);
      } catch (e){

      showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(e.toString()),
     ),);

   
      }
    } else{
        showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Passwords don't match"),
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

      body: isLoading?

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

            Text("Let's create an account for you!",
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

                   MyTextfield(
                    isPasswordField: true,
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPwController,
                ),

                SizedBox(height: 25,),

              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),

              SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Alredy have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                  ),
                   
                   SizedBox(width: 5,),
               
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Login now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade300,
                      fontSize: 20
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