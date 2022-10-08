// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:pet_cats_app/model/item.dart';
import 'package:pet_cats_app/pages/about.dart';
import 'package:pet_cats_app/pages/cat_language.dart';
import 'package:pet_cats_app/pages/catsproduct.dart';
import 'package:pet_cats_app/pages/checkout.dart';
import 'package:pet_cats_app/pages/clinic.dart';
import 'package:pet_cats_app/pages/contact.dart';
import 'package:pet_cats_app/pages/details_screen.dart';
import 'package:pet_cats_app/pages/todos.dart';
import 'package:pet_cats_app/pages/profile_page.dart';
import 'package:pet_cats_app/pages/training.dart';
import 'package:pet_cats_app/provider/cart.dart';
import 'package:pet_cats_app/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/Data.dart';
import 'ccare.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    return Scaffold(
        backgroundColor: Colors.purple[100],
        body: Padding(
          padding: const EdgeInsets.only(top: 22, bottom: 3),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 11,
                  mainAxisSpacing: 31),
              itemCount: Data.items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(product: Data.items[index]),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Stack(children: [
                      Positioned(
                        top: -3,
                        bottom: -1,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.asset(Data.items[index].imgPath)),
                      ),
                    ]),
                    footer: GridTileBar(
                      trailing: IconButton(
                          color: Colors.purple,
                          onPressed: () {
                            carttt.add(Data.items[index]);
                          },
                          icon: Icon(Icons.add)),
                      title: Text(""),
                      leading: Text("    ${Data.items[index].price}  \JOD     "),
                    ),
                  ),
                );
              }),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                      ),
                      currentAccountPicture: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              AssetImage("assets/images/beso.jpg")),
                      accountEmail: Text("Beso@gmail.com"),
                      accountName: Text("Beso",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                    ),
                    ListTile(
                        title: Text("Home"),
                        leading: Icon(Icons.home, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text('Cat products'),
                        leading: Icon(Icons.category, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Catsproduct(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text("My products"),
                        leading:
                            Icon(Icons.add_shopping_cart, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOut(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text('Care'),
                        leading:
                            Icon(Icons.health_and_safety, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Ccare(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text('Veterinary clinic'),
                        leading:
                            Icon(Icons.local_hospital, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Clinic(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text(
                          'Cats Body Language ',
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                        leading: Icon(Icons.pets, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => catl(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text(
                          'Training',
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                        leading:
                            Icon(Icons.sports_handball, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Training(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text(
                          'Task Solution',
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                        leading: Icon(Icons.task, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodoS(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text("About"),
                        leading: Icon(Icons.help_center, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => About(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text("Contact us "),
                        leading: Icon(Icons.contact_mail, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Contact(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text('My profile'),
                        leading: Icon(Icons.person, color: Colors.purple),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        }),
                    ListTile(
                        title: Text("Logout"),
                        leading: Icon(Icons.exit_to_app, color: Colors.purple),
                        onTap: () {}),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text("Developed by 4coders team © 2022",
                      style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            ProductsAndPrice(),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ],
            )
          ],
          backgroundColor: Colors.purple,
          title: Text("Home"),
        ));
  }
}
