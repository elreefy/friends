//FriendRequest model class
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
class FriendRequestModel {
  String? friendRequestId;
  String? senderId;
  String? receiverId;
  String? status;
  String? senderPhotoUrl;
  String? senderEmail;
  String? senderName;
  late bool read;
  late Timestamp dateTime;
  FieldValue? serverTimeStamp;


  FriendRequestModel({
    this.friendRequestId,
    this.senderId,
    this.receiverId,
    this.status,
    this.senderPhotoUrl,
    this.senderEmail,
    this.senderName,
   required this.dateTime,
  });
  FriendRequestModel.fromJson(Map<String, dynamic>? json){
    friendRequestId = json!['friendRequestId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    status = json['status'];
    senderPhotoUrl = json['senderPhotoUrl'];
    senderEmail = json['senderEmail'];
    senderName = json['senderName'];
  }
  Map<String, dynamic> toMap (){
    return {
      'friendRequestId':friendRequestId,
      'senderId':senderId,
      'receiverId':receiverId,
      'status':status,
      'senderPhotoUrl':senderPhotoUrl,
      'senderEmail':senderEmail,
      'dateTime': dateTime,
      'serverTimeStamp':serverTimeStamp,
      'senderName':senderName,
    };
  }
}
// Path: lib/data/models/Message.dart
// Compare this snippet from lib/data/models/Message.dart:
//   //Message model class
// import 'dart:core';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class Message {
//  String? messageId;
//  String? senderId;
//  String? receiverId;
//  String? message;
//  String? date;
//  String? time;
//  FieldValue? dateTime;
//  Message({
//    this.messageId,
//    this.senderId,
//    this.receiverId,
//    this.message,
//    this.date,
//    this.time,
//    this.dateTime,
// 
//  });
//  Message.fromJson