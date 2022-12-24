// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:pet_cats_app/model/cart_item_model.dart';
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
import 'package:pet_cats_app/services/database_service.dart';
import 'package:pet_cats_app/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:pet_cats_app/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../model/cat_model.dart';
import '../model/user_model.dart';
import '../services/auth_service.dart';
import 'ccare.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Cat>? cats;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _getCats();
    super.initState();
  }

  void _getCats() async {
    cats = await Database().getCats();
    setState(() {});
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.purple[100],
            title: Text(
              'Exit App',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Do you want to exit an App?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.purple),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10.0),
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.purple),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          backgroundColor: Colors.purple[100],
          body: cats == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 22, bottom: 3),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 11,
                          mainAxisSpacing: 31),
                      itemCount: cats!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Details(product: cats![index]),
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
                                  child: Image.network(cats![index].imageUrl),
                                ),
                              ),
                            ]),
                            footer: GridTileBar(
                              trailing: IconButton(
                                  color: Colors.purple,
                                  onPressed: () {
                                    cart.add(CartItem(
                                      imageUrl: cats![index].imageUrl,
                                      name: cats![index].name,
                                      price: cats![index].price,
                                      location: cats![index].location!,
                                    ));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Item added Successfully!",
                                            style: TextStyle(
                                                color: Colors.purple[100]),
                                          ),
                                        ),
                                        backgroundColor: Colors.purple,
                                        duration: Duration(
                                          seconds: 2,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.add_circle_outline)),
                              title: Text(""),
                              leading:
                                  Text("    ${cats![index].price}  JOD     "),
                            ),
                          ),
                        );
                      }),
                ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: SmartRefresher(
              header: WaterDropMaterialHeader(
                color: Colors.purple,
                backgroundColor: Colors.purple[100],
              ),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                setState(() {});
                _refreshController.refreshCompleted();
              },
              controller: _refreshController,
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
                            backgroundColor: Colors.purple[100],
                            //todo fix update image issue
                            backgroundImage: UserModel.shared.imageUrl.isEmpty
                                ? AssetImage('assets/images/beso.jpg')
                                : NetworkImage(UserModel.shared.imageUrl)
                                    as ImageProvider,
                          ),
                          accountEmail: Text(UserModel.shared.email),
                          accountName: Text(UserModel.shared.username,
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
                                  builder: (context) => CatsProduct(),
                                ),
                              );
                            }),
                        ListTile(
                            title: Text("My products"),
                            leading: Icon(Icons.add_shopping_cart,
                                color: Colors.purple),
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
                            leading: Icon(Icons.health_and_safety,
                                color: Colors.purple),
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
                            leading: Icon(Icons.local_hospital,
                                color: Colors.purple),
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
                                  builder: (context) => CatLanguage(),
                                ),
                              );
                            }),
                        ListTile(
                            title: Text(
                              'Training',
                              style: TextStyle(color: Colors.grey[900]),
                            ),
                            leading: Icon(Icons.sports_handball,
                                color: Colors.purple),
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
                            leading:
                                Icon(Icons.help_center, color: Colors.purple),
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
                            leading:
                                Icon(Icons.contact_mail, color: Colors.purple),
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
                          leading:
                              Icon(Icons.exit_to_app, color: Colors.purple),
                          onTap: () async {
                            await Loading.wrap(
                              context: context,
                              function: () async {
                                await AuthServices.logout(context: context);
                              },
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
                          },
                        ),
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
          )),
    );
  }
}
