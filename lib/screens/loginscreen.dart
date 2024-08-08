import 'package:flutter/material.dart';
import 'package:lawadvisor/Firebase/auth.dart';
import 'package:lawadvisor/Firebase/lawyer-auth.dart';
import 'package:lawadvisor/Mob_nav.dart';
import 'package:lawadvisor/UI_helper/inputfield.dart';
import 'package:lawadvisor/screens/forgotpassword.dart';
import 'package:lawadvisor/screens/signup-lawyer.dart';
import 'package:lawadvisor/screens/signup.dart';
import 'package:lawadvisor/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginLawyer() async {
    setState(() {
      _isloading = true;
    });
    String res = await LawyerAuth().loginLawyer(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }

  void loginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethod().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
          centerTitle: true,
          bottom:const  TabBar(
              indicatorColor: Color.fromRGBO(0, 167, 131, 1),
              indicatorWeight: 4,
              labelColor: Color.fromRGBO(0, 167, 131, 1),
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold
              ),
              tabs:
              [
                Tab(text: "User Login"),
                Tab(text: "Lawyer Login"),
              ]
          ),
        ),
        body: TabBarView(
          children: [
            _buildUserLogin(),
            _buildLawyerLogin()
          ],
        )
      ),
    );
  }
  Widget _buildUserLogin(){
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Image.asset('assets/lawadv2.png', height: 200),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your Email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isloading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                      : const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an Account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: Container(
                      child: const Text(
                        'Sign Up?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              // Adjust spacing
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLawyerLogin(){
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Image.asset('assets/lawadv2.png', height: 200,),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your Email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: loginLawyer,
                child: Container(
                  child: _isloading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                      : const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an Account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignUpScreenLawyer()),
                      );
                    },
                    child: Container(
                      child: const Text(
                        'Sign Up?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}


