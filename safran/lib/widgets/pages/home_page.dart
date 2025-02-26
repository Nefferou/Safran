import 'package:flutter/material.dart';
import 'package:safran/widgets/components/header/custom_header.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(),
    );
  }

}