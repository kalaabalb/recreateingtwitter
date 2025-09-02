class FirebaseUser{


  FirebaseUser copyWith({
    String? email,
    String? name,
    String? profilPic
  }) {
    return FirebaseUser(
      email: email ?? this.email,
      name:name ??this.name,
      profilPic: profilPic ?? this.profilPic,
    );
  }

  final String email;
  final  String name;
  final String profilPic;

  const FirebaseUser({
    required this.email,
    required this.name,
    required this.profilPic
  });

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'name': this.name,
      'profilPic': this.profilPic,
    };
  }

  factory FirebaseUser.fromMap(Map<String, dynamic> map) {
    return FirebaseUser(
      email: map['email'] as String,
      name: map['name'] as String,
      profilPic: map['profilPic'] as String,
    );
  }
}




