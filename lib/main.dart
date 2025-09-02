import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trail12/pages/home.dart';
import 'package:trail12/pages/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trail12/providers/user_provider.dart';
import 'firebase_options.dart';
 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              ref.read(userProvider.notifier).signinFetcher(asyncSnapshot.data!.email!);
              return Home();
            }
            return signIn();
          }),
    );
  }
}
