import 'package:flutter/material.dart';

import '../../components/header/custom_header.dart';

class HostGamePage extends StatelessWidget {

  const HostGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Host a game'),
          ],
        ),
      ),
    );
  }

}