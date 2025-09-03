import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trail12/providers/user_provider.dart';

class Settings extends ConsumerStatefulWidget{
  @override
  ConsumerState<Settings> createState() => _settingsState();
    // TODO: implement createState
  }

class _settingsState extends ConsumerState<Settings>{
  TextEditingController _namecontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    LocalUser currentUser= ref.watch(userProvider);
    _namecontroller.text=currentUser.user.name;
return Scaffold(
  appBar: AppBar(
    title: Text('Settings'),
  ),
  body: Column(
    children: [
      GestureDetector(
        onTap: ()async{
          final ImagePicker image= ImagePicker();
          final XFile? PickedImage= await image.pickImage(source: ImageSource.gallery);

          if(PickedImage!=null){
            ref.read(userProvider.notifier).updateProfile(File(PickedImage.path));
          }
        },
        child: CircleAvatar(
          radius: 100,
          backgroundImage: currentUser.user.profilPic.isNotEmpty
              ? NetworkImage(currentUser.user.profilPic)
              : const NetworkImage("http://www.gravatar.com/avatar/?d=mp"),
        )
        ,
      ),
      SizedBox(height: 10,),
      const Center(
        child: Text('Tap on the Image to change'),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Enter your name'),
          controller: _namecontroller,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(onPressed: (){
          ref.read(userProvider.notifier).updateUSer(_namecontroller.text);

        }, child: Text('update')),
      )
    ],
  ),
);
  }

}