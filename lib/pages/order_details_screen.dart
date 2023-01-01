// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:pet_cats_app/model/order_model.dart';
import 'package:pet_cats_app/pages/success_screen.dart';
import 'package:pet_cats_app/provider/cart.dart';
import 'package:pet_cats_app/shared/loading.dart';
import 'package:provider/provider.dart';

import '../services/database_service.dart';
import '../shared/dialog_helper.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  String mobileHint = "Mobile Number :";
  String mobilePrefixText = "";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
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
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          "Delivery Info",
                          style: TextStyle(fontSize: 33, fontFamily: "myfont"),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            "Please fill the fields below to let us deliver the order to you :",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(66),
                          ),
                          width: 266,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            onTap: () {
                              setState(() {
                                mobileHint = "XXXXXXXX";
                                mobilePrefixText = "07";
                              });
                            },
                            keyboardType: TextInputType.phone,
                            controller: mobileNumberController,
                            decoration: InputDecoration(
                                prefixText: mobilePrefixText,
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.purple[800],
                                ),
                                hintText: mobileHint,
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(66),
                          ),
                          width: 266,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: locationController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.purple[800],
                                ),
                                hintText: "Your Location :",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String mobileNumber =
                                "07${mobileNumberController.text}";
                            if (locationController.text.isEmpty) {
                              DialogHelper.shared.showErrorDialog(
                                  context: context,
                                  subTitle: "All fields are required");
                              return;
                            }
                            if (!validate(mobileNumber)) {
                              DialogHelper.shared.showErrorDialog(
                                  context: context,
                                  subTitle: "Please enter a valid mobile number");
                              return;
                            }
                            DialogHelper.shared.showAreYouSureDialog(
                              context: context,
                              title: "Place Order",
                              subTitle:
                                  "Are you sure you want to place the order?",
                              action: () async {
                                widget.order.mobileNumber = mobileNumber.trim();
                                widget.order.location = locationController.text;
                                await Loading.wrap(
                                  context: context,
                                  function: () async {
                                    await Database()
                                        .placeOrder(order: widget.order);
                                  },
                                );

                                cart.selectedProducts.clear();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SuccessScreen()));
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 97, vertical: 10)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27))),
                          ),
                          child: Text(
                            "ORDER",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
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

  bool validate(String mobileNumber) {
    String pattern = r'^07[789]\d{7}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(mobileNumber);
  }
}
