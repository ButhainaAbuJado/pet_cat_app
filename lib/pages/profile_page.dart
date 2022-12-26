// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_cats_app/model/user_model.dart';
import 'package:pet_cats_app/services/auth_service.dart';
import 'package:pet_cats_app/services/database_service.dart';
import 'package:pet_cats_app/shared/loading.dart';

import '../model/cart_item_model.dart';
import '../services/storage_service.dart';
import '../shared/dialog_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<CartItem> orderItems = [];

  @override
  void initState() {
    _getOrderItems();
    super.initState();
  }

  void _getOrderItems() async {
    orderItems = await Database().getOrderItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              DialogHelper.shared.showAreYouSureDialog(
                context: context,
                title: "Logout",
                subTitle: "Are you sure you want to logout?",
                action: () async {
                  await Loading.wrap(
                    context: context,
                    function: () async {
                      await AuthServices.logout(context: context);
                    },
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/login", (route) => false);
                },
              );
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
                    onPressed: () {
                      DialogHelper.shared.showAreYouSureDialog(
                        context: context,
                        title: "Delete User",
                        subTitle: "Are you sure you want to delete the user?",
                        action: () async {
                          await Loading.wrap(
                            context: context,
                            function: () async {
                              await AuthServices.deleteUser(context: context);
                            },
                          );
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/login", (route) => false);
                        },
                      );
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
                      width: MediaQuery.of(context).size.width - 50,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(11)),
                      child: Column(
                        children: [
                          const Text(
                            "Last Order Items",
                            style:
                                TextStyle(fontSize: 20, color: Colors.purple),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 120,
                              child: orderItems.isEmpty
                                  ? Center(
                                      child: Text(
                                        "no items available",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: orderItems.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            onTap: () {
                                              _rateItem(
                                                  item: orderItems[index],
                                                  context: context);
                                            },
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          orderItems[index]
                                                              .imageUrl),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                        );
                                      }),
                            ),
                          )
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  void _rateItem(
      {required CartItem item, required BuildContext context}) {
    double _rating = 5;
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Rate ${item.name}",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemSize: 30,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await Loading.wrap(context: context, function: () async {
                            await FirebaseFirestore.instance
                                .collection(item.collection!)
                                .doc(item.id)
                                .collection('rating')
                                .doc(UserModel.shared.userId)
                                .set({'rating': _rating.round()});
                          });
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple[100]),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27))),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
