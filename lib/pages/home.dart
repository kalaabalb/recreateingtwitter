import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trail12/providers/user_provider.dart';
import 'settings.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    LocalUser currentUser =ref.read(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
            shape  : RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20)
              )
            ),
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: ()=> Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(6.0),

                child: CircleAvatar(backgroundImage: NetworkImage(ref.watch(userProvider).user.profilPic)),
              ),
            );
          }
        )
        ,
        shadowColor: Colors.blue,
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(currentUser.user.email),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Image.network(currentUser.user.profilPic),
            ListTile(
              title: Text('Hello ${currentUser.user.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            ListTile(
              title: Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Settings()));
              },
            ),
            ListTile(
              title: Text('sign out',style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: (){

                FirebaseAuth.instance.signOut();
                ref.read(userProvider.notifier).Logout();              },
            )
          ],
        ),
      ),
    );
  }
}
