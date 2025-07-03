import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {

  final String text;
  final Widget redirectedPage;
  
  const BasicButton({super.key, required this.text, required this.redirectedPage});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => redirectedPage));
      },
      child: Text(text),
    );
  }

}