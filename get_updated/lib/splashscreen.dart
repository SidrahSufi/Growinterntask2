import 'dart:async';

import 'package:flutter/material.dart';
import 'news.dart';
class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(
          context,
         MaterialPageRoute(builder: (context)=>NewsScreen()));

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(


       decoration: BoxDecoration(
         image: DecorationImage(
          image:AssetImage("assets/newsbck.jpg"),
           fit: BoxFit.fill



       ),





      )
      )
    );
  }
}
