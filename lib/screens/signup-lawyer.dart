import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawadvisor/Firebase/lawyer-auth.dart';
import 'package:lawadvisor/Mob_nav.dart';
import 'package:lawadvisor/UI_helper/inputfield.dart';
import 'package:lawadvisor/screens/loginscreen.dart';
import 'package:lawadvisor/utils/utils.dart';


class SignUpScreenLawyer extends StatefulWidget {
  const SignUpScreenLawyer({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreenLawyer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _courtController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _speciController = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    _userNameController.dispose();
    _addressController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _licenseController.dispose();
    _courtController.dispose();
    _experienceController.dispose();
    _aboutController.dispose();
    _cityController.dispose();
    _speciController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigateToLoginIn() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void signUpLawyer() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _userNameController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _genderController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _licenseController.text.isEmpty ||
        _courtController.text.isEmpty ||
        _experienceController.text.isEmpty ||
        _aboutController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _speciController.text.isEmpty ||
        _image == null) {
      showSnackBar('Please fill all fields and select an image', context);
      return;
    }
    int? ageC = int.tryParse(_ageController.text);
    int? experienceC = int.tryParse(_experienceController.text);

    if (ageC == null || experienceC == null || ageC <= 0 || experienceC < 0) {
      showSnackBar('Please enter valid numeric values for age and experience', context);
      return;
    }
    setState(() {
      _isloading = true;
    });
    String res = await LawyerAuth().signUpLawyer(
        email: _emailController.text,
        password: _passwordController.text,
        username: _userNameController.text,
        mobile:_mobileController.text,
        file: _image!,
        age: int.parse(_ageController.text),
        gender: _genderController.text,
        address: _addressController.text,
        license: _licenseController.text,
        court: _courtController.text,
        experience: int.parse(_experienceController.text),
      about: _aboutController.text,
      city: _cityController.text,
      speci: _speciController.text
    );

    setState(() {
      _isloading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MobileScreenLayout(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lawyer SignUp"),
      ),
      body: SafeArea(
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              children: [
                // Move down to accommodate status bar
                Image.asset(
                  'assets/lawadv.png',
                  height:180,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                      radius: 54,
                      backgroundImage: MemoryImage(_image!),
                    )
                        : const CircleAvatar(
                      radius: 64,
                      child: Icon(
                        Icons.person,
                        size: 85,
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _userNameController,
                  hintText: "Enter your Username",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
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
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _mobileController,
                  hintText: "Enter your Mobile Number",
                  textInputType: TextInputType.number,
                ),

                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _cityController,
                  hintText: "Enter the city you work",
                  textInputType: TextInputType.text,
                ),

                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _aboutController,
                  hintText: "Enter you want to display about yourself",
                  textInputType: TextInputType.text,
                ),

                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _speciController,
                  hintText: "Enter your specialisation ",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _ageController,
                  hintText: "Enter your Age",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _genderController,
                  hintText: "Enter your Gender",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController:_addressController ,
                  hintText: "Enter your Address",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _licenseController,
                  hintText: "Enter your License Number",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _courtController,
                  hintText: "Enter which court you work in?",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _experienceController,
                  hintText: "how many years of experience do you have",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: signUpLawyer,
                  child: Container(
                    child: _isloading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : const Text("Sign up"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("have an Account?"),
                    GestureDetector(
                      onTap: navigateToLoginIn,
                      child: const Text(
                        'Log in?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
