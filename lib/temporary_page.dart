import 'package:flutter/material.dart';

class TemporaryPage extends StatelessWidget {
  //initState( ) fagaht tuye StatefullWidget ejra mishe.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temporary Page'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text('Temporary Page!!'),
        ),
      ),
    );
  }
}
