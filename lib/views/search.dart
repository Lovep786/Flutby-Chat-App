import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutby/helper/constants.dart';
import 'package:flutby/services/database.dart';
import 'package:flutby/views/conversation_screen.dart';
import 'package:flutby/widgets/widgets.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState()=>_SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController searchTextEditingController= new TextEditingController();
   QuerySnapshot searchSnapshot;
   Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.documents.length ,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return SearchTile(userName: searchSnapshot.documents[index].data["name"],
        userEmail: searchSnapshot.documents[index].data["email"],
        );
      },
      ):Container();
  }
  

   initiateSearch(){
     databaseMethods.getUsersByUsername(searchTextEditingController.text).then((val){
     setState(() {
       searchSnapshot=val;
     });
     });
   }
   moveToConvScreen(String chatroomId){
    Navigator.push(context, MaterialPageRoute(
           builder: (context)=> ConversationScreen(chatroomId)
           )
           );
   }
   createChatRoomAndStartConversation({BuildContext context,String userName}){
     
     if(userName!=Constants.myName){
       String chatRoomId = getChatRoomId(userName,Constants.myName);
       moveToConvScreen(chatRoomId);
     List<String> users = [userName,Constants.myName];
     Map<String,dynamic> chatRoomMap={
       "users":users,
       "chatRoomId": chatRoomId,
     };
     DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
     
     }else{
      print("you cannot send msg to yourself");
     }
    
   }
   
  

   Widget SearchTile({String userName,String userEmail}){
     return Container(
       padding: EdgeInsets.symmetric(horizontal:24,vertical :16),
       child: Row(
         children: <Widget>[
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children : [
               Text(userName,style: mediumTextStyle(),),
             Text(userEmail , style: mediumTextStyle(),),
             ] 
           ),
           Spacer(),
           GestureDetector(
             onTap: (){
                  createChatRoomAndStartConversation(userName:userName);
                 
             },
                        child: Container(
               decoration: BoxDecoration(
                 color:Colors.blue,
                 borderRadius:BorderRadius.circular(30),
               ),
               padding:EdgeInsets.symmetric(horizontal:16,vertical:8),
               child:Text("Message",style: mediumTextStyle(),),
             ),
           )
         ],
         ),
     );
   }

  
  @override
  void initState() {
    super.initState();
  }
  


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child : Column(
          children: <Widget>[
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal : 24,vertical :16),
           child :Row(children: <Widget>[
             Expanded(
               child: TextField(
                 controller: searchTextEditingController,
                 style :TextStyle(
                     color : Colors.white,
                   ),
                 decoration: InputDecoration(

                   hintText : "search username...",
                   hintStyle :TextStyle(
                     color : Colors.white54,
                   ),
                   border: InputBorder.none,

                 ),
               ),
               ),
             GestureDetector(
               onTap: (){
                  initiateSearch();
               },
                child: Container(
                 height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    gradient : LinearGradient(
                      colors: [
                        const Color(0x36FFFFFF),
                        const Color(0x0FFFFFFF)
                      ]
                      ),
                      borderRadius: BorderRadius.circular(40)
                  ),
                  padding: EdgeInsets.all(12),
                 child: Image.asset("images/search.png"),
               ),
             )
             
           ],),),
          searchList()
        ],
        )
      ),
    );
  }
 }

  

 getChatRoomId(String a,String b){
   if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
     return "$b\_$a";
   }else{
     return "$a\_$b";
   }
 }