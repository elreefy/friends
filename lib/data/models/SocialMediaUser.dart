// // Social maedia user model class is used to store the data of the user and from json to dart object
// import 'dart:core';
//
//
// class SocialMediaUser {
//   String? id;
//   String? name;
//   String? email;
//   String? profileImage;
//   String? coverImage;
//   String? bio;
//   String? website;
//   String? phone;
//   String? address;
//  //constructor
//   SocialMediaUser({
//     this.id,
//     this.name,
//     this.email,
//     this.profileImage,
//     this.coverImage,
//     this.bio,
//     this.website,
//     this.phone,
//     this.address,
//   });
//   //fromJson method
//   factory SocialMediaUser.fromJson(Map<String, dynamic> json) =>
//       _$SocialMediaUserFromJson(json);
//   //toJson method
//   Map<String, dynamic> toJson() => _$SocialMediaUserToJson(this);
//
// }
//
// class _$SocialMediaUserFromJson {
//
// }


class SocialMediaUser {
  SocialMediaUser({
    this.uid,
    this.name,
    this.email,
    this.profileImage,
    this.coverImage,
    this.bio,
    this.deviceToken,
    this.phone,
    this.address,
  });

  SocialMediaUser.fromJson(dynamic json) {
    uid = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    deviceToken = json['website'];
    phone = json['phone'];
    address = json['address'];
  }
  String? uid;
  String? name;
  String? email;
  String? profileImage;
  String? coverImage;
  String? bio;
  String? deviceToken;
  String? phone;
  String? address;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['coverImage'] = this.coverImage;
    data['bio'] = this.bio;
    data['website'] = this.deviceToken;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }

}