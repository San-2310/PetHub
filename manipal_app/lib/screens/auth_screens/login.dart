import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:manipal_app/components/navbar.dart';
import 'package:manipal_app/screens/auth_screens/signin.dart';
import 'package:manipal_app/components/colors.dart';
import 'package:manipal_app/components/primary_icon_button.dart';
import 'package:manipal_app/components/text_field_input.dart';
import 'package:manipal_app/components/utils.dart';
import 'package:manipal_app/controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:manipal_app/screens/home_screen/home_screen.dart';
import 'package:manipal_app/resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  RxBool isLoading = false.obs;
  AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainLayout(),
      ));
    } else {
      setState(() {
        _isLoading = true;
      });
      showSnackBar(res, context);
    }
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
                child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                'Log In',
                style: TextStyle(color: Colors.black, fontSize: 35),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppColors.darkGreen)),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Email",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextFieldInput(
                          hintText: 'Enter your email',
                          textEditingController: _emailController,
                          textInputType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      //password input
                      const Text(
                        "Password",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextFieldInput(
                        hintText: 'Enter your password',
                        textEditingController: _passwordController,
                        textInputType: TextInputType.text,
                        isPass: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      //button
                      InkWell(
                        onTap: () {
                          loginUser();
                        },
                        child: Container(
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.black,

                                  )
                                : const Text('Log In'),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                              AppColors.darkGreen,
                              AppColors.lightGreen,
                              AppColors.mediumGreen,
                              AppColors.mediumGreen,
                              AppColors.mediumGreen,
                              AppColors.mediumGreen,
                              AppColors.paleGreen,
                              AppColors.paleGreen
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                            )
                            )),
                      ),
                      const SizedBox(
                height: 24,
              ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("OR",style: TextStyle(
                    fontSize: 25
                  ),)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              
              Obx(
                () => isLoading.value
                    ? CircularProgressIndicator()
                    : PrimaryButtonWithIcon(
                        buttonText: "Sign in with Google",
                        onTap: () {
                          isLoading.value = true;
                          authController.login();
                        },
                        //iconPath: IconsPath.google,
                      ),
              ),
              //signup page link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToSignUp();
                    },
                    child: Container(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
                ),
              ),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:tic_tac_toe/components/primary_icon_button.dart';
// import 'package:tic_tac_toe/configs/assets_path.dart';
// import 'package:tic_tac_toe/controllers/auth_controller.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     RxBool isLoading = false.obs;
//     AuthController authController = Get.put(AuthController());
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       IconsPath.applogo,
//                       width: w / 1.6,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Text(
//                   "Welcome",
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//                 Text(
//                   "Please Sign In to Continue",
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//                 SizedBox(
//                   height: h / 6,
//                 ),
//               ],
//             ),
//             Obx(
//               () => isLoading.value
//                   ? CircularProgressIndicator()
//                   : PrimaryButtonWithIcon(
//                       buttonText: "Sign in with Google",
//                       onTap: () {
//                         isLoading.value = true;
//                         authController.login();
//                       },
//                       iconPath: IconsPath.google,
//                     ),
//             ),
//             SizedBox(
//               height: h / 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }