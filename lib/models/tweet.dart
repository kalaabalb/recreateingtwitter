import 'package:cloud_firestore/cloud_firestore.dart';

class Tweet{
  final String id;
  final String name;
  final String profilPic;
  final String tweet;
  final  Timestamp postTime;



  Tweet({
    required this.id,
    required this.name,
    required this. profilPic,
    required this.tweet,
    required this.postTime

});

  Tweet copyWith({
    String? id,
    String? name,
    String? profilPic,
    String? tweet,
    Timestamp? postTime,
  }) {
    return Tweet(
      id: id ?? this.id,
      name: name ?? this.name,
      profilPic: profilPic ?? this.profilPic,
      tweet: tweet ?? this.tweet,
      postTime: postTime ?? this.postTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilPic': profilPic,
      'tweet': tweet,
      'postTime': postTime,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      id: map['id'] as String,
      name: map['name'] as String,
      profilPic: map['profilPic'] as String,
      tweet: map['tweet'] as String,
      postTime: map['postTime'] as Timestamp,
    );
  }
}