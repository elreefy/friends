//post model class is used to store the data of the post and from json to dart object
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
class Post {
  String? postId;
  String? name;
  String? uId;
  String profilePicture = 'https://www.gstatic.com/webp/gallery/1.jpg';
  String? post;
  String? postImage;
  int? likes;
  int? comments;
  Timestamp? date;
  String? time;
  FieldValue? dateTime;
  bool? isLiked;



  Post({
    this.postId,
    this.name,
    this.uId,
    required this.profilePicture,
    this.post,
    this.postImage,
    this.likes,
    this.comments,
    this.time,
    this.date,
    this.dateTime,
    this.isLiked,
  });

  Post.fromJson(Map<String, dynamic>? json){
    postId = json!['postId'];
    name = json['name'];
    uId = json['uId'];
    profilePicture = json['profilePicture'];
    post = json['postText'];
    postImage = json['postImage'];
    likes = json['likes'];
    comments = json['comments'];
    time = json['time'];
    date = json['date'];
    isLiked = json['isLiked'];

  }

  Map<String, dynamic> toMap (){
    return {
      'postId':postId,
      'name':name,
      'uId' : uId,
      'profilePicture':profilePicture,
      'postText':post,
      'postImage': postImage,
      'likes':likes,
      'comments':comments,
      'time':time,
      'date': date,
      'dateTime': dateTime,
      'isLiked': isLiked,
    };
  }
}
//Compare this snippet from lib/data/models/userModel.dart:
// // User