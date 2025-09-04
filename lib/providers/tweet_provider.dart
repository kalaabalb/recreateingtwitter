import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trail12/models/tweet.dart';
import 'package:trail12/models/user.dart';
import 'package:trail12/providers/user_provider.dart';

final tweetProvider = Provider<TweetApi>((ref) {
  return  TweetApi(ref);
});



class TweetApi{
  TweetApi(this.ref);
  final Ref ref;



  final FirebaseFirestore  _firestore = FirebaseFirestore.instance;

  Future <void> PostTweet(String tweet) async{
    LocalUser currentUser= ref.read(userProvider);
    await _firestore.collection('tweets').add(Tweet(
        id: currentUser.id,
        name: currentUser.user.name,
        profilPic: currentUser.user.profilPic,
        tweet: tweet,
        postTime: Timestamp.now()
    ).toMap()
    );
  }

}