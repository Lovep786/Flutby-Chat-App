import 'package:flutby/helper/authenticate.dart'; 
import 'package:flutby/views/chatRoomsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutby/helper/helperfunctions.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn=false;

  @override
  void initState(){
    getLoggedInState();
    super.initState();
  }


  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPrefrence().then((value){
    setState(() {
      userIsLoggedIn=value;
    });
    }) ;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        
      ),
      home: userIsLoggedIn ? ChatRoom() :Authenticate(),
      
    );
  }
}


