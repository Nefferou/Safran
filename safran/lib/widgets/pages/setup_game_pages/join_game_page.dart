import 'package:flutter/material.dart';

import '../../components/header/custom_header.dart';

class JoinGamePage extends StatelessWidget {

  const JoinGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Join a game'),
          ],
        ),
      ),
    );
  }

}