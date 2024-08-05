import 'package:flutter/material.dart';
import 'package:lawadvisor/Firebase/auth.dart';
import 'package:lawadvisor/Mob_nav.dart';
import 'package:lawadvisor/UI_helper/inputfield.dart';
import 'package:lawadvisor/screens/forgotpassword.dart';
import 'package:lawadvisor/screens/signup.dart';
import 'package:lawadvisor/utils/utils.dart';
class LoginScreen extends StatefulWidget{
  const LoginScreen ({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  bool _isloading =false;

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // void navigateToSignUp(){
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(),));
  // }
  void loginUser() async{
    setState(() {
      _isloading = true;
    });
    String res= await AuthMethod().loginUser(email: _emailController.text, password: _passwordController.text);

    if(res=='success') {

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const  MobileScreenLayout(),));

    }else{
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(child: Container(),flex: 2,),

             Image.asset('assets/lawadv.png' ,height: 250,),

              TextFieldInput(textEditingController: _emailController, hintText: "Enter your Email", textInputType: TextInputType.emailAddress),

              const SizedBox(height: 24,),

              TextFieldInput(textEditingController: _passwordController, hintText: "Enter your password", textInputType: TextInputType.text,isPass: true,),

              const SizedBox(height: 14,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ForgotPassword(),));
                  },child: Text("Forgot Password?",style: TextStyle(fontSize: 12,),)),
                ],
              ),

              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isloading ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ) :const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(4)
                      )
                  ),
                      color: Colors.blue
                  ),
                ),
              ),

              const SizedBox(height: 24,),

              Flexible(child: Container(),flex: 2,),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text( "Don't have an Account?"),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const  SignUpScreen(),));
                      },
                      child: Container(
                        child: const Text('Sign Up?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8
                        ),
                      ),
                    )
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}