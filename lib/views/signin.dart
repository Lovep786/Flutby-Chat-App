
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutby/helper/helperfunctions.dart';
import 'package:flutby/services/auth.dart';
import 'package:flutby/services/database.dart';
import 'package:flutby/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'chatRoomsScreen.dart';

class SignIn extends StatefulWidget {
  final Function toogle;
  SignIn(this.toogle);
  @override
  _SignInState createState()=>_SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey=GlobalKey<FormState>();
  AuthMethods authMethods=new AuthMethods();
  DatabaseMethods databaseMethods=new DatabaseMethods();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  bool isLoading=false;
  QuerySnapshot snapshotUserInfo;

  signIn(){
    if(formKey.currentState.validate())
   {
     //HelperFunctions.saveUserNameSharedPrefrence(userNameTextEditingController.text);
      HelperFunctions.saveUserEmailSharedPrefrence(emailTextEditingController.text);
      databaseMethods.getUsersByUserEmail(emailTextEditingController.text).then((val){
       snapshotUserInfo=val;
      HelperFunctions
      .saveUserNameSharedPrefrence(snapshotUserInfo.documents[0].data["name"]);
      });
      setState(() {
        isLoading=true;
      });
      
      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        if(val != null){
           HelperFunctions.saveUserLoggedInSharedPrefrence(true);
         Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context)=> ChatRoom()
           )
           );
        }
      });
     
   }  
   }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
      child :Container(
        height: MediaQuery.of(context).size.height - 50,
        alignment: Alignment.center,
        child:Container(
        padding: EdgeInsets.symmetric(horizontal :24),
      child :Column(
        mainAxisSize: MainAxisSize.min,
        children : [
          Form(
            key: formKey,
                      child: Column(
              children :[
                TextFormField(
                  validator: (val){
                return val.isEmpty ?"Please provide suitable email" : null;
                },
              controller: emailTextEditingController,
              style: simpleTextStyle(),
              decoration:textFieldInputDecoration("email"),
            ),
            TextFormField(
              validator: (val){
                return val.length < 6 ?"Password should be grater than six characters" : null ;
                },
              controller: passwordTextEditingController,
              obscureText: true,
              style: simpleTextStyle(),
              decoration:textFieldInputDecoration("password"),
            ),
              ]
            ),
          ),
          SizedBox(
            height:16,
          ),
          Container(
            alignment: Alignment.centerRight,
          child :Container(
            padding: EdgeInsets.symmetric(horizontal : 16,vertical:8),
            child:Text("Forgot Password",style: simpleTextStyle(),),
          ),
          ),
          SizedBox(
            height:8,
          ),
          GestureDetector(
            onTap: (){
              signIn();
            },
                      child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical : 20),
              decoration: BoxDecoration(
                gradient : LinearGradient(
                  colors :[const Color(0xff007EF4),
                  const Color(0xff2A75BC),
                  ]
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text("Sign In",style : TextStyle(
                color:Colors.white,
                fontSize: 17,
            ),
             ),
            ),
          ),
          SizedBox(
            height:16,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical : 20),
            decoration: BoxDecoration(
              color :Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text("Sign In with Google",style : TextStyle(
              color:Colors.black,
              fontSize: 17,
          ),
           ),
          ),
          SizedBox(
            height:16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children :[
              Text("Don't have account?",style : mediumTextStyle(),),
              GestureDetector(
                onTap: (){
                  widget.toogle();
                },
              child:Container(
                padding: EdgeInsets.symmetric(vertical : 8),
              child :Text(" Register Now",style : TextStyle(
              color:Colors.white,
              fontSize: 17,
              decoration: TextDecoration.underline
    ),
    ),
          ),
          ),
            ]
          ),
          SizedBox(
            height:50,
          ),
        ]
      ),
      ),
    ),
      ),
    );
  }
 }