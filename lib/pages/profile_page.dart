// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_cats_app/model/user_model.dart';
import 'package:pet_cats_app/services/auth_service.dart';
import 'package:pet_cats_app/shared/loading.dart';

import '../services/storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await Loading.wrap(
                context: context,
                function: () async {
                  await AuthServices.logout(context: context);
                },
              );
              Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
            },
            label: const Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.purple,
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    ClipOval(),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.2,
                      backgroundImage: UserModel.shared.imageUrl.isEmpty
                          ? AssetImage('assets/images/beso.jpg')
                          : NetworkImage(UserModel.shared.imageUrl)
                              as ImageProvider,
                      backgroundColor: Colors.purple[100],
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.purple),
                        child: IconButton(
                          onPressed: () async {
                            final image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            File img = File(image!.path);
                            String url = '';
                            await Loading.wrap(
                              context: context,
                              function: () async {
                                url = await StorageService.uploadProfilePicture(
                                    UserModel.shared.imageUrl, img);
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(UserModel.shared.userId)
                                    .update({"imageUrl": url});
                              },
                            );
                            setState(() {
                              UserModel.shared.imageUrl = url;
                            });
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    " Email:   ${UserModel.shared.email}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    //

                    "Created date:   ${UserModel.shared.createdDate.split(".")[0]} ",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    //
                    " Last Signed In:   ${UserModel.shared.lastSignedIn.split(".")[0]}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Center(
                child: TextButton(
                    onPressed: () async {
                      await Loading.wrap(
                        context: context,
                        function: () async {
                          await AuthServices.deleteUser(context: context);
                        },
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
                    },
                    child: const Text(
                      "Delete User",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
              const SizedBox(
                height: 22,
              ),
              Center(
                  child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(11)),
                      child: const Text(
                        "Info from firebase firestore",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
