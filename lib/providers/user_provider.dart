import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trail12/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<userNotifier, LocalUser>((ref) {
  return userNotifier();
});
class LocalUser{
  final String id;
  final FirebaseUser user;

 const LocalUser({required this.id, required this.user});

  LocalUser copyWith({
    String? id,
    FirebaseUser? user,
  }) {
    return LocalUser(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }


}

class userNotifier extends StateNotifier<LocalUser> {
userNotifier(): super(LocalUser(id: 'error', user: FirebaseUser(email: 'error', name: 'error', profilPic: 'error')));
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage=FirebaseStorage.instance;

Future<void> signinFetcher(String email)async{
  QuerySnapshot response= await _firestore.collection('users').where("email" , isEqualTo: email).get();

  if(response.docs.isEmpty){
    print("no user is in the email $email");
  }
  else if(response.docs.length!=1){
    print('there is more than one user in the email $email');
  }
  state = LocalUser(id: response.docs[0].id, user: FirebaseUser.fromMap(response.docs[0].data() as Map<String,dynamic>));

}
Future<void> updateUSer(String name)async{
  await _firestore.collection('users').doc(state.id).update({
    'name':name
  });
  state = state.copyWith(user: state.user.copyWith(name: name));
}


Future<void> updateProfile(File image) async {
  final url = Uri.parse("https://api.cloudinary.com/v1_1/dufzv48ep/image/upload");
  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = 'kalaabalb'

    ..files.add(await http.MultipartFile.fromPath('file', image.path));

  final response = await request.send();
  final res = await http.Response.fromStream(response);

  if (res.statusCode == 200) {
    final data = json.decode(res.body);
    final profileURL = data['secure_url'];

    await _firestore.collection('users').doc(state.id).update({"profilPic": profileURL});
    state = state.copyWith(user: state.user.copyWith(profilPic: profileURL));
  } else {
    print("Upload failed: ${res.body}");
  }
}
Future<void> signupFetcher(String email) async {

  DocumentReference response=  await _firestore
      .collection('users')
      .add(FirebaseUser(email: email, name: 'no Name', profilPic: 'http://www.gravatar.com/avatar/?d=mp').toMap());
  DocumentSnapshot snapshot= await response.get();
  state=  LocalUser(id: response.id, user: FirebaseUser.fromMap(snapshot.data() as Map<String,dynamic>));
}
void Logout(){
  const LocalUser(
      id: 'error',
      user: FirebaseUser(email: 'error', name: 'error', profilPic: 'error')
  );
}
}