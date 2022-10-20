import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text("Page not found"),
      ),
      body: const Center(
        child: Text("Page is not available."),
      ),
    );
  }
}
