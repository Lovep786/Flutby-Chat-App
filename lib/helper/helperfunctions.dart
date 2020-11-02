import 'package:shared_preferences/shared_preferences.dart';
class HelperFunctions{
  static String sharedPrefrencesUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefrencesUserNameKey="USERNAMEKEY";
  static String sharedPrefrencesUserEmailKey="USEREMAILKEY";

  static Future<bool> saveUserLoggedInSharedPrefrence(bool isUserLoggedIn) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefrencesUserLoggedInKey, isUserLoggedIn);
  }
  static Future<bool> saveUserNameSharedPrefrence(String userName) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefrencesUserNameKey, userName);
  }
  static Future<bool> saveUserEmailSharedPrefrence(String userEmail) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefrencesUserEmailKey, userEmail);
  }
   
   static Future<bool> getUserLoggedInSharedPrefrence() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getBool(sharedPrefrencesUserLoggedInKey);
  }

static Future<String> getUserNameSharedPrefrence() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefrencesUserNameKey);
  }
  static Future<String> getUserEmailSharedPrefrence() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefrencesUserEmailKey);
  }

}