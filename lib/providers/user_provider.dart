import 'package:cloud_firestore/cloud_firestore.dart';
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