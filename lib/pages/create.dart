import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trail12/providers/tweet_provider.dart';
import 'package:trail12/providers/user_provider.dart';

class Create extends ConsumerWidget {
  const Create({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Tweet'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(border:OutlineInputBorder() ),
              controller: _controller,
              maxLines: 4,
              maxLength: 300,
            ),
            TextButton(onPressed: (){
              ref.read(tweetProvider).PostTweet(_controller.text);
              Navigator.pop(context);
            }, child: Text('Post Tweet'))
          ],
        ),
      ),
    );
  }
}
