import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_cats_app/model/user_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:pet_cats_app/services/auth_service.dart';
import 'package:pet_cats_app/shared/dialog_helper.dart';
import 'package:pet_cats_app/shared/loading.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        const Text(
                          "Log in",
                          style: TextStyle(fontSize: 33, fontFamily: "myfont"),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        SvgPicture.asset(
                          "assets/icons/login.svg",
                          width: 288,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(66),
                          ),
                          width: 266,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.purple[800],
                                ),
                                hintText: "Username :",
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(66),
                          ),
                          width: 266,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                suffix: Icon(
                                  Icons.visibility,
                                  color: Colors.purple[900],
                                ),
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.purple[800],
                                  size: 19,
                                ),
                                hintText: "Password :",
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if(usernameController.text.isEmpty || passwordController.text.isEmpty){
                              DialogHelper.shared.showErrorDialog(context: context, subTitle: "All fields are required");
                              return ;
                            }
                            if(!validateStructure(passwordController.text)){
                              DialogHelper.shared.showErrorDialog(context: context,title: 'Invalid Password', subTitle: "Your password should have Uppercase and lowercase letters, Numerics and Special Characters ( ! @ # \$ & * ~ )");
                              return ;
                            }
                            bool isValidCredential = false;
                            await Loading.wrap(
                              context: context,
                              function: () async {
                                isValidCredential = await AuthServices.signIn(
                                  username: usernameController.text.trim(),
                                  password: passwordController.text,
                                  context: context,
                                );
                              },
                            );

                            if (isValidCredential) {
                              await _fillUserModel(context: context);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/Home',
                                (route) => false,
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 97, vertical: 10)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27))),
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              style: const ButtonStyle(),
                              child: const Text(
                                "Forgot Password ?",
                                style: TextStyle(color: Colors.purple),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("/forgotPassword");
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 37,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an accout? "),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/signup");
                                },
                                child: const Text(
                                  " Sign up",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Image.asset(
                    "assets/images/main_top.png",
                    width: 111,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/login_bottom.png",
                    width: 111,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> _fillUserModel({required BuildContext context}) async{
    await Loading.wrap(
      context: context,
      function: () async {
        final user = FirebaseAuth.instance.currentUser!;
        final firestoreUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        UserModel.shared.userId = user.uid;
        UserModel.shared.username = firestoreUser.get('username');
        UserModel.shared.email = user.email!;
        UserModel.shared.createdDate = user.metadata.creationTime.toString();
        UserModel.shared.lastSignedIn = user.metadata.lastSignInTime.toString();
        UserModel.shared.imageUrl = firestoreUser.get('imageUrl');
      },
    );
  }

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
