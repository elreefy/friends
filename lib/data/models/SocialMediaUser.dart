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
    this.password,
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
    password = json['password'];
  }
  String? uid;
  String? name;
  String? email;
  String? profileImage;
  String? coverImage;
  String? bio;
  String? deviceToken;
  String? phone;
  String? password;

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
    data['password'] = this.password;
    return data;
  }

}