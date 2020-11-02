import 'package:flutby/helper/helperfunctions.dart';
import 'package:flutby/services/auth.dart';
import 'package:flutby/views/chatRoomsScreen.dart';
import 'package:flutby/services/database.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class SignUp extends StatefulWidget {
  final Function toogle;
  SignUp(this.toogle);
  @override
  _SignUpState createState()=>_SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMethods authmethods = new AuthMethods();
  HelperFunctions helperFunctions=new HelperFunctions();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formKey =  GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

   signMeUp(){
     if(formKey.currentState.validate()){
       
       Map<String,String> userInfoMap={
        "name":userNameTextEditingController.text,
        "email":emailTextEditingController.text,
      };
      HelperFunctions.saveUserNameSharedPrefrence(userNameTextEditingController.text);
      HelperFunctions.saveUserEmailSharedPrefrence(emailTextEditingController.text);

       setState(() {
         isLoading=true;
       });

       authmethods.signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
         //print("$val");
       databaseMethods.uploadUserInfo(userInfoMap);
       HelperFunctions.saveUserLoggedInSharedPrefrence(true);
         Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context)=> ChatRoom()
           )
           );
       });
     }
   }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center (child : CircularProgressIndicator() ),
      ): SingleChildScrollView(
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
            children: <Widget>[
              TextFormField(
                validator: (val){
                return val.isEmpty || val.length < 4 ?"Please provide suitable username" : null;
                },
            controller: userNameTextEditingController,
            style: simpleTextStyle(),
            decoration:textFieldInputDecoration("username"),
          ),
          TextFormField(
            
            validator: (val){
                return val.isEmpty ?"Please provide suitable email" : null;
                },
            controller: emailTextEditingController,
            style: simpleTextStyle(),
            decoration:textFieldInputDecoration("email"),
          ),
          TextFormField(
            obscureText: true,
            validator: (val){
                return val.length < 6 ?"Password should be grater than six characters" : null ;
                },
            controller: passwordTextEditingController,
            style: simpleTextStyle(),
            decoration:textFieldInputDecoration("password"),
          ),
            ],
          ),),
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
             signMeUp();
            },
          child :Container(
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
            child: Text("Sign Up",style : TextStyle(
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
            child: Text("Sign Up with Google",style : TextStyle(
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
              Text("Have an account?",style : mediumTextStyle(),),
              GestureDetector(
                onTap: (){
                  widget.toogle();
                },
              child:Container(
                padding: EdgeInsets.symmetric(vertical : 8),
              child :Text(" SignIn Now",style : TextStyle(
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