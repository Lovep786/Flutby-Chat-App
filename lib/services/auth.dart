import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutby/modal/user.dart';


class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: deprecated_member_use
  UserId _userFromFirebaseUser(FirebaseUser user){
    return user != null ? UserId(userId: user.uid) : null;
  } 

  Future signInWithEmailAndPassword(String email,String password) async{
    try{
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       // ignore: deprecated_member_use
       FirebaseUser firebaseUser = result.user;
       return _userFromFirebaseUser(firebaseUser);
       
    }catch(e){
    print(e.toString());
    }
  }
  Future signUpWithEmailAndPassword(String email,String password) async{
    try{
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       // ignore: deprecated_member_use
       FirebaseUser firebaseUser = result.user;
       return _userFromFirebaseUser(firebaseUser);
       
    }catch(e){
    print(e.toString());
    }
  }

  Future resetPassword(String email) async{
    try{
       return await _auth.sendPasswordResetEmail(email: email);
       
    }catch(e){
    print(e.toString());
    }
  }

  Future signOut() async{
    try{
       return await _auth.signOut();
       
    }catch(e){
    print(e.toString());
    }
  }

}

