  //Message model class
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
class Message {
 String? messageId;
 String? senderId;
 String? receiverId;
 String? message;
 String? date;
 String? time;
 Timestamp? dateTime;
 Message({
   this.messageId,
   this.senderId,
   this.receiverId,
   this.message,
   this.date,
   this.time,
   this.dateTime,

 });
 Message.fromJson(Map<String, dynamic>? json){
   messageId = json!['messageId'];
   senderId = json['senderId'];
   receiverId = json['receiverId'];
   message = json['message'];
   date = json['date'];
   time = json['time'];
   dateTime = json['dateTime'];
 }
 Map<String, dynamic> toMap (){
   return {
     'messageId':messageId,
     'senderId':senderId,
     'receiverId':receiverId,
     'message':message,
     'date':date,
     'time':time,
     'dateTime':dateTime,

   };
 }
}
